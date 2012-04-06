module Restful
  class Adapter < DataMapper::Adapters::AbstractAdapter
    # This shit is a hack
    undef :read
    undef :update
    undef :delete

    def create(resources)
      resources.each { |resource|
        dirty_attributes = resource.dirty_attributes.inject({}) { |hash, (k,v)| hash.update(k.name => v) }
        resource.attributes = Request.post(resource.model.name, dirty_attributes)
      }.size
    end
  end
end
