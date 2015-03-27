# encoding: utf-8
module TinCanApi
  # Statement Class
  class Statement < Statements::StatementsBase

    attr_accessor :id, :stored, :authority, :version, :voided

    def initialize(options={}, &block)
      super(options, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.id = attributes['id'] if attributes['id']
        self.stored =  Time.parse(attributes['stored']) if attributes['stored']
        self.authority = TinCanApi::Agent.new(json: attributes['authority'].to_json) if attributes['authority']
        self.version = attributes['version'] if attributes['version']
        self.voided = attributes['voided'] if attributes['voided']
      else
        self.id = options.fetch(:id, nil)
        self.stored = options.fetch(:stored, nil)
        self.authority = options.fetch(:authority, nil)
        self.version = options.fetch(:version, nil)
        self.voided = options.fetch(:voided, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = super(version)

      node['id'] = id if id
      node['stored'] = stored.strftime('%FT%T%:z') if stored
      node['authority'] = authority.serialize(version) if authority

      if version == TinCanApi::TCAPIVersion::V095
        node['voided'] = voided if voided
      end

      if version.ordinal <= TinCanApi::TCAPIVersion::V100.ordinal
        node['version'] = version.to_s if version
      end
      node
    end

    def stamp
      @id = SecureRandom.uuid
      @timestamp = Time.now
    end
  end
end