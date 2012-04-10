module Restful
  class Request
    def self.post(model_name, attributes)
      path = 'localhost:4000/heffalumps'
      params = attributes
      Configuration.backend.call(:post, path, params)
    end

    def self.get(model_name, params)
      path = 'localhost:4000/heffalumps'
      Configuration.backend.call(:get, path, params)
    end
  end
end
