# encoding: utf-8
module TinCanApi
  class Verb

    attr_accessor :id, :display

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.id = attributes['id'] if attributes['id']
        self.display = attributes['display'] if attributes['display']
      else
        self.id = options.fetch(:id, nil)
        self.display = options.fetch(:display, nil)

        if block_given?
          block[self]
        end
      end
    end

    def id=(value)
      @id = Addressable::URI.parse(value) if value
    end

    def serialize(version)
      node = {}
      node['id'] = id.to_s if id
      node['display'] = display if display
      node
    end

  end
end