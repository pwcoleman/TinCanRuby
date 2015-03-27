# encoding: utf-8
module TinCanApi
  class SubStatement < Statements::StatementsBase

    attr_accessor :object_type

    def initialize(options={}, &block)
      @object_type = 'SubStatement'
      super(options, &block)
    end

    def serialize(version)
      node = super(version)
      node['objectType'] = object_type
      node
    end

  end
end