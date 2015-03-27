# encoding: utf-8
require 'spec_helper'

describe TinCanApi::Group do
  include Helpers

  it 'should serialize and deserialize' do
    members = (1..10).map {|member| get_agent("Member #{member}", :mbox, "mailto:#{member}@example.com")}
    group = TinCanApi::Group.new
    group.name = 'Group'
    group.mbox = 'mailto:group@example.com'
    group.members = members
    assert_serialize_and_deserialize(group)
  end
end