module Restful
  class Adapter < DataMapper::Adapters::AbstractAdapter

    def create(resources)
      resources.map { |resource|
        dirty_attributes = resource.dirty_attributes.inject({}) { |hash, (k,v)| hash.update(k.name => v) }
        response = Request.post(resource.model.storage_name, dirty_attributes)
        if response.status == 200
          properties =  resource.model.properties
          response.body.each do |attr_name, val|
            if prop = properties[attr_name.to_sym]
              prop.set!(resource, val)
            end
          end
        end
      }.compact.size
    end

    def read(query)
      Request.get(query.model.storage_name, query.params).body
    end

    def update(attrs, resources)
      resources.map do |resource|
        attr_hash = attrs.inject({}) { |h, (k, v)| h.merge(k.name => v) }
        response = Request.put(resource.model.storage_name, resource.key, attr_hash)
        if response.status == 200
          properties =  resource.model.properties.inspect
          response.body.except(:id).each do |k, v|
            if prop = properties[k.to_sym]
              prop.set!(resource, v)
            end
          end
        end
      end.compact.size
    end

    def delete(resources)
      resources.each do |resource|
        Request.delete(resource.model.storage_name, resource.key)
      end.size
    end
  end
end

class DataMapper::Query

  def params
    options.inject({}) do |hash, (k,v)|
      k = case k
      when DataMapper::Query::Operator
        [k.target, '.', k.operator].join
       when DataMapper::Property::Serial
         k.name
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
