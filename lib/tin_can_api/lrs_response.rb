# encoding: utf-8
module TinCanApi
  class LrsResponse
    attr_accessor :success, :error_message, :content, :status

    def initialize(&block)
      if block_given?
        block[self]
      end
    end


  end
end