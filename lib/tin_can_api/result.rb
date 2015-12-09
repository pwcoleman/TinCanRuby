# encoding: utf-8
require 'ruby-duration'
module TinCanApi
  # Result Model class
  class Result

    attr_accessor :score, :success, :completion, :duration, :response, :extensions

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.score = TinCanApi::Score.new(json: attributes['score'].to_json) if attributes['score']
        self.success = attributes['success'] unless attributes['success'].nil?
        self.completion = attributes['completion'] unless attributes['completion'].nil?
        self.duration = Duration.new(attributes['duration']) if attributes['duration']
        self.response = attributes['response'] if attributes['response']
        self.extensions = attributes['extensions'] if attributes['extensions']
      else
        self.score = options.fetch(:score, nil)
        self.success = options.fetch(:success, nil)
        self.completion = options.fetch(:completion, nil)
        self.duration = options.fetch(:duration, nil)
        self.response = options.fetch(:response, nil)
        self.extensions = options.fetch(:extensions, nil)

        if block_given?
          block[self]
        end
      end
    end

    def serialize(version)
      node = {}
      node['score'] = score.serialize(version) if score
      node['success'] = success unless success.nil?
      node['completion'] = completion unless completion.nil?
      node['duration'] = duration.iso8601 if duration
      node['response'] = response if response
      node['extensions'] = extensions if extensions

      node
    end
  end
end
