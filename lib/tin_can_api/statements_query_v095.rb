# encoding: utf-8
module TinCanApi
  class StatementsQueryV095

    attr_reader :version, :verb_id
    attr_accessor :object, :registration, :context, :actor, :stored_since, :stored_until, :limit
    attr_accessor :authoritative, :sparse, :instructor, :ascending

    def initialize(&block)
      self.version = TCAPIVersion::V095
      if block_given?
        block[self]
      end
    end

    def verb_id=(value)
      if value.is_a?(Verb)
        @verb_id = value.id
      else
        @verb_id = Addressable::URI.parse(value)
      end
    end

    def parameter_map
      params = {}
      params['verb'] = verb_id.to_s if verb_id
      params['object'] = object.serialize(version) if object
      params['registration'] = registration if registration
      params['context'] = context if context
      params['actor'] = actor if actor
      params['since'] = stored_since.strftime('%FT%T%:z') if stored_since
      params['until'] = stored_until.strftime('%FT%T%:z') if stored_until
      params['limit'] = limit if limit
      params['authoritative'] = authoritative if authoritative
      params['sparse'] = sparse if sparse
      params['instructor'] = instructor.serialize(version) if instructor
      params['ascending'] = ascending if ascending

      params
    end
  end
end