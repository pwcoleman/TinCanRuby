# encoding: utf-8
require 'spec_helper'

describe TinCanApi::Statement do
  include Helpers

  it 'should serialize and deserialize' do
    targets = []
    activity = TinCanApi::Activity.new
    activity.id = 'http://example.com/activity'
    targets << activity
    targets << get_agent('Target', 'mbox', 'mailto:target@example.com')
    ref = TinCanApi::StatementRef.new
    ref.id = SecureRandom.uuid
    targets << ref

    sub = TinCanApi::SubStatement.new
    sub.actor = get_agent('Sub', 'mbox', 'mailto:sub@example.com')
    verb = TinCanApi::Verb.new
    verb.id = 'http://example.com/verb'
    sub.verb = verb
    activity = TinCanApi::Activity.new
    activity.id = 'http://example.com/sub-activity'
    sub.object = activity
    targets << sub

    statement = TinCanApi::Statement.new
    statement.actor = get_agent('Joe', 'mbox', 'mailto:joe@example.com')
    attachment = TinCanApi::Attachment.new
    attachment.sha2 = '123'
    statement.attachments = [attachment]

    statement.authority = get_agent('Authority', 'mbox', 'mailto:authority@example.com')

    context = TinCanApi::Context.new
    context.language = 'en-US'
    statement.context = context

    statement.id = SecureRandom.uuid

    result = TinCanApi::Result.new
    result.completion = true
    statement.result = result

    statement.stored = Time.now
    statement.timestamp = Time.now

    verb = TinCanApi::Verb.new
    verb.id = 'http://example.com/verb'
    statement.verb = verb

    targets.each do |target|
      statement.object = target
      assert_serialize_and_deserialize(statement)
    end
  end
end
