# encoding: utf-8
module TinCanApi
  # Score model class
  class Score

    attr_accessor :scaled, :raw, :min, :max

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.scaled = attributes['scaled'] if attributes['scaled']
        self.raw = attributes['raw'] if attributes['raw']
        self.min = attributes['min'] if attributes['min']
        self.max = attributes['max'] if attributes['max']
      else
        self.scaled = options.fetch(:scaled, nil)
        self.raw = options.fetch(:raw, nil)
        self.min = options.fetch(:min, nil)
        self.max = options.fetch(:max, nil)

        if block_given?
          block[self]
        end
      end

    end

    def serialize(version)
      node = {}
      node['scaled'] = scaled if scaled
      node['raw'] = raw if raw
      node['min'] = min if min
      node['max'] = max if max
      node
    end

  end
end