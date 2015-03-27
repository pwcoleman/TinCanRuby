# encoding: utf-8
require 'spec_helper'

describe TinCanApi::StatementRef do
  include Helpers

  it 'sets the object type' do
    ref = TinCanApi::StatementRef.new
    expect(ref.object_type).to eq('StatementRef')
  end

  it 'should serialize and deserialize' do
    ref = TinCanApi::StatementRef.new
    ref.id = SecureRandom.uuid

    assert_serialize_and_deserialize(ref)
  end

end
