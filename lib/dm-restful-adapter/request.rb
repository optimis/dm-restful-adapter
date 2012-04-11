module Restful
  class Request
    def self.post(model_name, attrs)
      Configuration.backend.call(:post, resourceify(model_name), attrs)
    end

    def self.get(model_name, attrs)
      Configuration.backend.call(:get, resourceify(model_name), attrs)
    end

    def self.put(model_name, id, attrs)
      Configuration.backend.call(:put, resourceify(model_name, id), model_name.downcase => attrs)
    end

    def self.delete(model_name, id)
      Configuration.backend.call(:delete, resourceify(model_name, id))
    end

    private

    def self.resourceify(model_name, id=nil)
      ["localhost:4000/#{model_name.downcase.pluralize}", id].compact.join('/')
    end
  end
end
