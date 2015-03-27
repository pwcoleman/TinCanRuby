# encoding: utf-8
require 'spec_helper'

describe TinCanApi::InteractionComponent do
  include Helpers

  it 'should serialize and deserialize' do
    component = TinCanApi::InteractionComponent.new
    component.id = 'choice1'

    map = {}
    map['en-US'] = 'Some choice'
    component.description = map

    assert_serialize_and_deserialize(component)
  end

end