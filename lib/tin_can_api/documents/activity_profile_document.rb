# encoding: utf-8
module TinCanApi
  module Documents
    class ActivityProfileDocument < Document

      attr_accessor :activity

      def initialize(&block)
        super(&block)
      end

    end
  end
end

