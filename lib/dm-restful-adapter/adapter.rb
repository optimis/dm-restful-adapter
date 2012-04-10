module Restful
  class Adapter < DataMapper::Adapters::AbstractAdapter
    # This shit is a hack
    undef :update
    undef :delete

    def create(resources)
      resources.each { |resource|
        dirty_attributes = resource.dirty_attributes.inject({}) { |hash, (k,v)| hash.update(k.name => v) }
        resource.attributes = Request.post(resource.model.name, dirty_attributes)
      }.size
    end

    def read(query)
      Request.get(query.model.name, query.params)
    end

  end
end

class DataMapper::Query

  def params
    options.inject({}) do |hash, (k,v)|
      k = case k
      when DataMapper::Query::Operator
        [k.target, '.', k.operator].join
      else
        k
      end
      k,v = fix_array_param_key(k,v)
      hash.merge(k => v)
    end
  end

  def fix_array_param_key(key, value)
    if Array === value
      ["#{key}[]", value]
    else
      [key, value]
    end
  end

end
