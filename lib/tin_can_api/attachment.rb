# encoding: utf-8
module TinCanApi
  # Attachment Class
  class Attachment

    attr_accessor :display, :description, :content_type, :length, :sha2
    attr_reader :usage_type, :file_url

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.usage_type = attributes['usageType'] if attributes['usageType']
        self.display = attributes['display'] if attributes['display']
        self.description = attributes['description'] if attributes['description']
        self.content_type = attributes['contentType'] if attributes['contentType']
        self.length = attributes['length'] if attributes['length']
        self.sha2 = attributes['sha2'] if attributes['sha2']
        self.file_url = attributes['fileUrl'] if attributes['fileUrl']
      else
        self.usage_type = options.fetch(:usage_type, nil)
        self.display = options.fetch(:display, nil)
        self.description = options.fetch(:description, nil)
        self.content_type = options.fetch(:content_type, nil)
        self.length = options.fetch(:length, nil)
        self.sha2 = options.fetch(:sha2, nil)
        self.file_url = options.fetch(:file_url, nil)

        if block_given?
          block[self]
        end
      end
    end

    def usage_type=(value)
      if value.is_a?(String)
        @usage_type = Addressable::URI.parse(value)
      else
        @usage_type = value
      end
    end

    def file_url=(value)
      if value.is_a?(String)
        @file_url = Addressable::URI.parse(value)
      else
        @file_url = value
      end
    end

    def serialize(version)
      node = {}
      node['usageType'] = usage_type.to_s if usage_type
      node['display'] = display if display
      node['description'] = description if description
      node['contentType'] = content_type if content_type
      node['length'] = length if length
      node['sha2'] = sha2 if sha2
      node['fileUrl'] = file_url.to_s if file_url
      node
    end

  end
end