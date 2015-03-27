# encoding: utf-8
require 'spec_helper'

describe TinCanApi::SubStatement do
  include Helpers

  it 'should serialize and deserialize' do
    statement = TinCanApi::SubStatement.new
    statement.actor = get_agent('Joe', 'mbox', 'mailto:joe@example.com')
    context = TinCanApi::Context.new
    context.language = 'en-US'
    statement.context = context

    activity = TinCanApi::Activity.new
    activity.id = 'http://example.com/activity'
    statement.object = activity

    result = TinCanApi::Result.new
    result.completion = true
    statement.result = result

    statement.timestamp = Time.now

    verb = TinCanApi::Verb.new
    verb.id = 'http://example.com/verb'
    statement.verb = verb

    assert_serialize_and_deserialize(statement)
  end
end
