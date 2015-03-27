# encoding: utf-8
module TinCanApi
  # StatementRef Class used when referencing another statement from a statement's object property
  class StatementRef

    attr_accessor :object_type, :id

    def initialize(options={}, &block)
      @object_type = 'StatementRef'
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.id = attributes['id'] if attributes['id']
      else
        self.id = options.fetch(:id, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = {}
      node['id'] = id if id
      node['objectType'] = object_type
      node
    end

  end
end