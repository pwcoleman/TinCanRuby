# encoding: utf-8
module TinCanApi
  module Documents
    class AgentProfileDocument < Document

      attr_accessor :agent

      def initialize(&block)
        super(&block)
      end

    end
  end
end

