# encoding: utf-8
module TinCanApi
  # InteractionComponent Class Description
  class InteractionComponent

    attr_accessor :id, :description

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.id = attributes['id'] if attributes['id']
        self.description = attributes['description'] if attributes['description']
      else
        self.id = options.fetch(:id, nil)
        self.description = options.fetch(:description, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = {}
      node['id'] = id if id
      node['description'] = description if description
      node
    end

  end
end