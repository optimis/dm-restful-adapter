require 'dm-core'
require 'typhoeus'
require 'multi_json'
require "dm-restful-adapter/version"

module Restful
  autoload :Adapter,       'dm-restful-adapter/adapter'
  autoload :Request,       'dm-restful-adapter/request'
  autoload :Configuration, 'dm-restful-adapter/configuration'

  module Backends
    autoload :Typhoeus, 'dm-restful-adapter/backends/typhoeus'
  end
end

DataMapper::Adapters::RestfulAdapter = Restful::Adapter
