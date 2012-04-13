module Restful
  module Request
    extend self

    def post(storage_name, attrs)
      Configuration.backend.call(:post, resourceify(storage_name), attrs)
    end

    def get(storage_name, attrs)
      Configuration.backend.call(:get, resourceify(storage_name), attrs)
    end

    def put(storage_name, id, attrs)
      Configuration.backend.call(:put, resourceify(storage_name, id), storage_name.singularize => attrs)
    end

    def delete(storage_name, id)
      Configuration.backend.call(:delete, resourceify(storage_name, id))
    end

    def resourceify(storage_name, id=nil)
      [Configuration.domain, storage_name, id].compact.join('/')
    end
  end
end
