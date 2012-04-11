require 'net/http'
require 'uri'

module Restful
  module Backends
    class Net::HTTP
      def self.call(method, path, params={})
        raise 'Use typhoeus or write this your damn yourself!'
      end
    end
  end
end
