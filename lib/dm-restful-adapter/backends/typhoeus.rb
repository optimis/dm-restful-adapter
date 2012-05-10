module Restful
  module Backends
    class Typhoeus
      def self.call(method, path, params={})
        response = ::Typhoeus::Request.run(path, :method => method, :params => params)
        ::Restful::Response.new(:body => Configuration.parser.decode(response.body), :status => response.code)
      end
    end
  end
end
