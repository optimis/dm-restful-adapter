require 'mimic'
require 'supermodel'

class HeffalumpModel < SuperModel::Base
end

Mimic.mimic(:port => 4000) do
  post "/heffalumps" do
    heffalump = HeffalumpModel.new(params)
    if heffalump.save
      [200, {}, heffalump.attributes.to_json]
    else
      [422, {}, heffalump.attributes.to_json]
    end
  end
end
