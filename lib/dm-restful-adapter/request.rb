module Restful
  module Request
    extend self

    def post(model_name, attrs)
      Configuration.backend.call(:post, resourceify(model_name), attrs)
    end

    def get(model_name, attrs)
      Configuration.backend.call(:get, resourceify(model_name), attrs)
    end

    def put(model_name, id, attrs)
      Configuration.backend.call(:put, resourceify(model_name, id), model_name.downcase => attrs)
    end

    def delete(model_name, id)
      Configuration.backend.call(:delete, resourceify(model_name, id))
    end

    def resourceify(model_name, id=nil)
      [Configuration.domain, model_name.downcase.pluralize, id].compact.join('/')
    end
  end
end
