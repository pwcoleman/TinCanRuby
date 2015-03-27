# encoding: utf-8
module TinCanApi
  # Group model class
  class Group < Agent

    attr_accessor :members

    def initialize(options={}, &block)
      super(options, &block)

      @object_type = 'Group'
      @members = []
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        attributes['member'].each do |member|
          members << Agent.new(json: member.to_json)
        end
      else
        self.members = options.fetch(:members, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = super(version)
      if members.any?
        node['member'] = members.map {|member| member.serialize(version)}
      end
      node
    end

  end
end