# encoding: utf-8
require 'tin_can_api/tcapi_version'
module TinCanApi
  # Agent model class
  class Agent

    attr_accessor :name, :mbox, :mbox_sha1_sum, :open_id, :account, :object_type

    def initialize(options={}, &block)
      @object_type = 'Agent'
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.name = attributes['name'] if attributes['name']
        self.mbox = attributes['mbox'] if attributes['mbox']
        self.mbox_sha1_sum = attributes['mbox_sha1sum'] if attributes['mbox_sha1sum']
        self.open_id = attributes['openid'] if attributes['openid']
        self.account = AgentAccount.new(json: attributes['account'].to_json) if attributes['account']
      else
        self.name = options.fetch(:name, nil)
        self.mbox = options.fetch(:mbox, nil)
        self.mbox_sha1_sum = options.fetch(:mbox_sha1_sum, nil)
        self.open_id = options.fetch(:open_id, nil)
        self.account = options.fetch(:account, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = {}
      node['objectType'] = object_type
      node['name'] = name if name
      node['mbox'] = mbox if mbox
      node['mbox_sha1sum'] = mbox_sha1_sum if mbox_sha1_sum
      node['openid'] = open_id if open_id
      node['account'] = account.serialize(version) if account
      node
    end

  end
end
