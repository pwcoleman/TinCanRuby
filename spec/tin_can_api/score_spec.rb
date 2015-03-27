# encoding: utf-8
require 'spec_helper'

describe TinCanApi::Score do
  include Helpers

  it 'should serialize and deserialize' do
    score = TinCanApi::Score.new(max: 100.0, min: 0.0, raw: 80.0, scaled: 0.8)

    assert_serialize_and_deserialize(score)
  end
end
