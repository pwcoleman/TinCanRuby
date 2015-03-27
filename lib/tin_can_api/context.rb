# encoding: utf-8
module TinCanApi
  # Context Class Description
  class Context

    attr_accessor :registration, :instructor, :team, :context_activities, :revision
    attr_accessor :platform, :language, :statement, :extensions

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.registration = attributes['registration'] if attributes['registration']
        self.instructor = TinCanApi::Agent.new(json: attributes['instructor'].to_json) if attributes['instructor']
        self.team = TinCanApi::Agent.new(json: attributes['team'].to_json) if attributes['team']
        self.context_activities = TinCanApi::ContextActivities.new(json: attributes['contextActivities'].to_json) if attributes['contextActivities']
        self.revision = attributes['revision'] if attributes['revision']
        self.platform = attributes['platform'] if attributes['platform']
        self.language = attributes['language'] if attributes['language']
        self.statement = TinCanApi::StatementRef.new(json: attributes['statement'].to_json) if attributes['statement']
        self.extensions = attributes['extensions'] if attributes['extensions']
      else
        self.registration = options.fetch(:registration, nil)
        self.instructor = options.fetch(:instructor, nil)
        self.team = options.fetch(:team, nil)
        self.context_activities = options.fetch(:context_activities, nil)
        self.revision = options.fetch(:revision, nil)
        self.platform = options.fetch(:platform, nil)
        self.language = options.fetch(:language, nil)
        self.extensions = options.fetch(:extensions, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = {}
      node['registration'] = registration if registration
      node['instructor'] = instructor.serialize(version) if instructor
      node['team'] = team.serialize(version) if team
      node['contextActivities'] = context_activities.serialize(version) if context_activities
      node['revision'] = revision if revision
      node['platform'] = platform if platform
      node['language'] = language if language
      node['statement'] = statement.serialize(version) if statement
      node['extensions'] = extensions if extensions

      node
    end

  end
end