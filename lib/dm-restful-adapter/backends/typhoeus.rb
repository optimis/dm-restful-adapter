module Restful
  module Backends
    class Typhoeus
      def self.call(method, path, params={})
        response = ::Typhoeus::Request.run(path, :method => method, :params => params)
        Configuration.parser.decode(response.body)
      end
    end
  end
end
