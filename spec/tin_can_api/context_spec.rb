# encoding: utf-8
require 'spec_helper'

describe TinCanApi::Context do
  include Helpers

  it 'should serialize and deserialize' do
    context = TinCanApi::Context.new
    activities = TinCanApi::ContextActivities.new
    activity = TinCanApi::Activity.new
    activity.id = 'http://example.com/activity'
    activities.parent = [activity]
    context.context_activities = activities

    map = {}
    map['http://example.com/extension'] = 'extension value'
    context.extensions = map

    context.instructor = get_agent('Instructor', 'mbox', 'mailto:instructor@example.com')
    context.language = 'en-US'
    context.platform = 'iPhone 5'
    context.registration = SecureRandom.uuid
    context.revision = '1.2.3'
    ref = TinCanApi::StatementRef.new
    ref.id = SecureRandom.uuid
    context.statement = ref
    context.team = get_agent('Group', 'mbox', 'mailto:group@example.com')

    assert_serialize_and_deserialize(context)
  end

end
