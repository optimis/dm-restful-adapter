module Restful
  module Configuration
    extend self

    def backend
      Backends::Typhoeus
    end
  end
end
