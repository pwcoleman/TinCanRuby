# encoding: utf-8
module TinCanApi
  # Activity Definition model class
  class ActivityDefinition
    include TinCanApi::InteractionType

    attr_accessor :name, :description, :extensions, :interaction_type, :correct_responses_pattern
    attr_accessor :choices, :scale, :source, :target, :steps
    attr_reader :type, :more_info

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        self.type = attributes['type'] if attributes['type']
        self.more_info = attributes['moreInfo'] if attributes['moreInfo']
        self.name = attributes['name'] if attributes['name']
        self.description = attributes['description'] if attributes['description']
        self.extensions = attributes['extensions'] if attributes['extensions']
        self.interaction_type = attributes['interactionType'] if attributes['interactionType']

        if attributes['correctResponsesPattern']
          self.correct_responses_pattern = []
          attributes['correctResponsesPattern'].each do |pattern|
            correct_responses_pattern << pattern
          end
        end

        if attributes['choices']
          self.choices = []
          attributes['choices'].each do |choice|
            choices << InteractionComponent.new(choice.to_json)
          end
        end

        if attributes['scale']
          self.scale = []
          attributes['scale'].each do |element|
            scale << InteractionComponent.new(element.to_json)
          end
        end

        if attributes['source']
          self.source = []
          attributes['source'].each do |element|
            source << InteractionComponent.new(element.to_json)
          end
        end

        if attributes['target']
          self.target = []
          attributes['target'].each do |element|
            target << InteractionComponent.new(element.to_json)
          end
        end

        if attributes['steps']
          self.steps = []
          attributes['steps'].each do |element|
            steps << InteractionComponent.new(element.to_json)
          end
        end

      else
        self.name = options.fetch(:name, nil)
        self.description = options.fetch(:description, nil)
        self.extensions = options.fetch(:extensions, nil)
        self.interaction_type = options.fetch(:interaction_type, nil)
        self.correct_responses_pattern = options.fetch(:correct_responses_pattern, nil)
        self.choices = options.fetch(:choices, nil)
        self.scale = options.fetch(:scale, nil)
        self.source = options.fetch(:source, nil)
        self.target = options.fetch(:target, nil)
        self.type = options.fetch(:type, nil)
        self.more_info = options.fetch(:more_info, nil)

        if block_given?
          block[self]
        end
      end
    end

    def type=(value)
      if value.is_a?(String)
        @type = Addressable::URI.parse(value)
      else
        @type = value
      end
    end

    def more_info=(value)
      if value.is_a?(String)
        @more_info = Addressable::URI.parse(value)
      else
        @more_info = value
      end
    end

    def serialize(version)
      node = {}
      node['name'] = name if name
      node['description'] = description if description
      node['type'] = type.to_s if type
      node['moreInfo'] = more_info.to_s if more_info
      node['extensions'] = extensions if extensions
      if interaction_type
        node['interactionType'] = interaction_type.to_s
        case interaction_type
          when TinCanApi::InteractionType::CHOICE.to_s, TinCanApi::InteractionType::SEQUENCING.to_s
            if choices && choices.any?
              node['choices'] = choices.map {|element| element.serialize(version)}
            end
          when TinCanApi::InteractionType::LIKERT.to_s
            if scale && scale.any?
              node['scale'] = scale.map {|element| element.serialize(version)}
            end
          when TinCanApi::InteractionType::MATCHING.to_s
            if source && source.any?
              node['source'] = source.map {|element| element.serialize(version)}
            end
            if target && target.any?
              node['target'] = target.map {|element| element.serialize(version)}
            end
          when TinCanApi::InteractionType::PERFORMANCE.to_s
            if steps && steps.any?
              node['steps'] = steps.map {|element| element.serialize(version)}
            end
        end
      end

      if correct_responses_pattern && correct_responses_pattern.any?
        node['correctResponsesPattern'] = correct_responses_pattern.map {|element| element}
      end

      node
    end

  end
end
