# encoding: utf-8
require 'spec_helper'

describe TinCanApi::ActivityDefinition do
  include Helpers

  it 'should serialize and deserialize' do
    definition = TinCanApi::ActivityDefinition.new
    definition.choices = create_interaction_component('choice1', 'Choice 1')
    definition.correct_responses_pattern = ['correct_response']

    map = {}
    map['en-US'] = 'Activity Definition Description'
    definition.description = map

    extensions = {}
    extensions['http://example.com/extensions'] = 'extensionValue'
    definition.extensions = extensions

    map = {}
    map['en-US'] = 'Activity Definition'
    definition.name = map

    definition.scale = create_interaction_component('scale1', 'Scale 1')
    definition.source = create_interaction_component('source1', 'Source 1')
    definition.steps = create_interaction_component('steps1', 'Steps 1')
    definition.target = create_interaction_component('target1', 'Target 1')

    definition.type = 'http://adlnet.gov/expapi/activities/assessment'

    TinCanApi::InteractionType.values.each do |type|
      definition.interaction_type = type
      assert_serialize_and_deserialize(definition)
    end

  end
end