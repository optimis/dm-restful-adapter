module Restful
  module Configuration
    extend self

    def backend
      Backends::Typhoeus
    end

    def domain
      @domain or raise 'You must define a domain: Restful::Configuration.domain = "www.example.com"'
    end

    def domain=(domain)
      @domain = domain
    end
  end
end
