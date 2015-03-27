# encoding: utf-8
require 'json'
module TinCanApi
  # Agent Account model class
  class AgentAccount

    attr_accessor :home_page, :name

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.name = attributes['name'] if attributes['name']
        self.home_page = attributes['homePage'] if attributes['homePage']
      else
        self.home_page = options.fetch(:home_page, nil)
        self.name =options.fetch(:name, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = {}
      node['name'] = name if name
      node['homePage'] = home_page if home_page
      node
    end

  end
end