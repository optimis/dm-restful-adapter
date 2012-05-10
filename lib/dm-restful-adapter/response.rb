module Restful
  class Response
    def initialize(options={})
      @body = options[:body]
      @status = options[:status]
    end

    def body
      @body
    end

    def status
      @status
    end
  end
end
