require 'mimic'
require 'active_record'
require 'spec/support/setup_mimic_db'

class HeffalumpModel < ActiveRecord::Base
  self.include_root_in_json = false

  def self.search(params)
    params = format_params(params)
    params, regex_params = extract_regex_params(params)
    result = query(params)
    filter_from_regexps(regex_params, result)
  end

  def self.format_params(params)
    params.inject({}) do |new_hash, (k, v)|
      new_hash.merge(k => coerce_value(v))
    end
  end

  def self.coerce_value(value)
    case value
    when /(.+)(\.{3})(.+)/
      Range.new($1.to_i, $3.to_i - 1)
    when /(.+)(\.{2})(.+)/
      Range.new($1.to_i, $3.to_i)
    when /\(\?[m|i|x|\-]{4}\:.*\)/
      Regexp.new(value)
    else
      value
    end
  end

  def self.extract_regex_params(params)
    params.partition { |k,v| !v.is_a?(Regexp) }
  end

  def self.query(params)
    params.inject(scoped) do |s, (k, v)|
      s = case k
      when /(.*)(\.not)/
        s.where(arel_table[$1].not_in(v))
      when /(.*)(\.gte)$/
        s.where(arel_table[$1].gteq(v))
      when /(.*)(\.gt)$/
        s.where(arel_table[$1].gt(v))
      when /(.*)(\.lte)$/
        s.where(arel_table[$1].lteq(v))
      when /(.*)(\.lt)$/
        s.where(arel_table[$1].lt(v))
      when /(.*)(\.like)/
        s.where(arel_table[$1].matches(v))
      when 'limit'
        s.limit(v)
      when 'conditions'
        s.where(:num_spots => 5)
      when 'order'
         s.order(v)
      when 'offset'
         s.offset(v)
      else
        s.where(k => v)
      end
    end
  end

  def self.filter_from_regexps(params, result)
    params.each do |k,v|
      result = case k
      when /(.*)(\.not)/
        result.reject { |rec| v.match rec[$1] }
      else
        result.select { |rec| v.match rec[k] }
      end
    end
    result
  end
end

Mimic.mimic(:port => 4000) do
  post "/heffalumps" do
    heffalump = HeffalumpModel.new(params)
    if heffalump.save
      response = heffalump.to_json
      [200, {'Content-Type' => 'application/json', 'Content-Length' => response.bytesize}, response]
    else
      response = heffalump.to_json
      [422, {'Content-Type' => 'application/json', 'Content-Length' => response.bytesize}, response]
    end
  end

  get "/heffalumps" do
    if params.empty?
      lumps = HeffalumpModel.all
    else
      lumps = HeffalumpModel.search(params)
    end
    response = lumps.to_json
    [200, {'Content-Type' => 'application/json', 'Content-Length' => response.bytesize}, response]
  end

  put "/heffalumps/:id" do
    heffalump = HeffalumpModel.find(params['id'])
    heffalump.update_attributes(params['heffalump'])
    response = heffalump.to_json
    [200, {'Content-Type' => 'application/json', 'Content-Length' => response.bytesize}, response]
  end

  delete "/heffalumps/:id" do
    heffalump = HeffalumpModel.find(params['id'])
    heffalump.destroy
    response =  [].to_json
    [200, {'Content-Type' => 'application/json', 'Content-Length' => response.bytesize}, response]
  end
end
