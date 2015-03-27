# encoding: utf-8
module TinCanApi
  class About
    attr_accessor :versions, :extensions

    def initialize(options={})
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        @versions = attributes['version'] if attributes['version']
        @extensions = attributes['extensions'] if attributes['extensions']
      end
    end
  end
end