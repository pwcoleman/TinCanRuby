# encoding: utf-8
module TinCanApi
  module Documents
    class Document

      attr_accessor :id, :etag, :timestamp, :content_type, :content

      def initialize(&block)
        if block_given?
          block[self]
        end
      end

    end
  end
end

require_relative 'activity_profile_document'
require_relative 'agent_profile_document'
require_relative 'state_document'