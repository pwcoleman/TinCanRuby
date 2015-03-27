module Helpers
  def get_agent(name, type, value)
    agent = TinCanApi::Agent.new(name: name)
    case type
      when :mbox
        agent.mbox =  value
      when :open_id
        agent.open_id = value
      when :mbox_sha1_sum
        agent.mbox_sha1_sum = value
      when :account
        parts = value.split('|')
        account = TinCanApi::AgentAccount.new(home_page: parts.first, name: parts.last)
        agent.account = account
    end
    agent
  end

  def create_interaction_component(id, description)
    component = TinCanApi::InteractionComponent.new
    component.id = id
    map = {}
    map['en-US'] = description
    component.description = map
    [component]
  end

  def assert_serialize_and_deserialize(object)
    TinCanApi::TCAPIVersion.values.each do |version|
      assert_serialize_and_deserialize_for_version(object, version)
    end
  end

  def assert_serialize_and_deserialize_for_version(object, version)
    hash = object.serialize(version)
    new_definition = object.class.new(json: hash.to_json)
    expect(hash).to eq(new_definition.serialize(version))
  end

  def default_request_headers
    {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.1', 'X-Experience-Api-Version'=>'1.0.1'}
  end
end