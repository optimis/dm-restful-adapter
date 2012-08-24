require 'dm-core'
require 'typhoeus'
require 'multi_json'
require 'dm-restful-adapter/version'

module Restful
  autoload :Adapter,       'dm-restful-adapter/adapter'
  autoload :Request,       'dm-restful-adapter/request'
  autoload :Response,       'dm-restful-adapter/response'
  autoload :Configuration, 'dm-restful-adapter/configuration'

  module Backends
    module Net
      autoload :HTTP, 'dm-restful-adapter/backends/net_http'
    end
    autoload :Typhoeus, 'dm-restful-adapter/backends/typhoeus'
  end
end

Kernel.silence_warnings do
  DataMapper::Adapters::RestfulAdapter = Restful::Adapter
end
