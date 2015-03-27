# encoding: utf-8
require 'spec_helper'

describe TinCanApi::Agent do
  include Helpers
  it 'should serialize and deserialize' do
    agent = TinCanApi::Agent.new
    name = 'Joe User'
    ids = {
        mbox: 'mailto:joeuser@example.com',
        open_id: 'http://openid.org/joeuser',
        mbox_sha1_sum: 'b623062e19c5608ab0e1342e5011d48292ce00e3',
        account: 'http://example.com|joeuser'
    }
    ids.each_pair do |key, value|
      TinCanApi::TCAPIVersion.values.each do |version|
        agent = get_agent(name, key, value)
        hash = agent.serialize(version)
        new_agent = TinCanApi::Agent.new(json: hash.to_json)
        expect(hash).to eq(new_agent.serialize(version))
      end
    end
  end
end
