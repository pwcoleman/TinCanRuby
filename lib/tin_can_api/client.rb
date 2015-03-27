# encoding: utf-8
require 'faraday'
require 'addressable/uri'
require 'tin_can_api/tcapi_version'
module TinCanApi
  # Class used to communicate with a TCAPI endpoint synchronously
  class Client
    include TinCanApi::TCAPIVersion

    VALID_PARAMS = %w(end_point user_name password version)

    attr_accessor :end_point, :user_name, :password, :version

    def initialize(options={}, &block)
      setup_options(options)
      yield_or_eval(&block) if block_given?
      @version ||= latest_version
    end

    def about
      response = connection.get("#{path}about")
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status== 200
          lrs.content = About.new(json: response.body)
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def save_statement(statement)
      # TODO: Complete this
      if statement.id
        response = connection.put do |req|
          req.url("#{path}statements")
          req.headers['Content-Type'] = 'application/json'
          req.params.merge!({'statementId' => statement.id})
          req.body = statement.serialize(latest_version).to_json
        end
      else
        response = connection.post do |req|
          req.url("#{path}statements")
          req.headers['Content-Type'] = 'application/json'
          req.body = statement.serialize(latest_version).to_json
        end
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        lrs.content = statement
        if response.status == 200
          statement.id = JSON.parse(response.body).first
          lrs.success = true
        elsif response.status == 204
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def save_statements(statements)
      # TODO: Complete this
      if statements.empty?
        return LrsResponse.new do |lrs|
          lrs.success = true
        end
      end
      response = connection.post do |req|
        req.url("#{path}statements")
        req.headers['Content-Type'] = 'application/json'
        req.body = statements.map {|s| s.serialize(latest_version)}.to_json
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status == 200
          lrs.content = statements
          ids = JSON.parse(response.body)
          statements.each_with_index do |statement, index|
            statement.id = ids[index]
          end
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def retrieve_statement(id)
      get_statement(id, 'statementId')
    end

    def retrieve_voided_statement(id)
      param_name = version == TCAPIVersion.V095 ? 'statementId' : 'voidedStatementId'
      get_statement(id, param_name)
    end

    def query_statements(statement_query)
      # TODO: Complete this
      query = statement_query
      unless query
        query = version == TCAPIVersion::V095 ? StatementsQueryV095.new : StatementsQuery.new
      end
      # Error if the query parameters don't match the LRS version
      raise Errors::IncompatibleTCAPIVersion, "Attempted to issue #{version} query using a #{query.version} set of query parameters." unless version == query.version

      response = connection.get do |req|
        req.url("#{path}statements")
        req.params.merge!(query.parameter_map)
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status == 200
          # TODO: FIX THIS
          lrs.success = true
          lrs.content = StatementsResult.new(json: response.body)
        else
          lrs.success = false
        end
      end
    end

    def more_statements(more_url)
      # TODO: Complete this
      # more_url is relative to the endpoint's server root
      response = connection.get do |req|
        req.url("#{path}#{more_url}")
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status == 200
          # TODO: FIX THIS
          lrs.success = true
          lrs.content = StatementsResult.new(json: response.body)
        else
          lrs.success = false
        end
      end
    end

    def retrieve_state_ids(activity, agent, registration)
      # TODO: Complete this
      query_params = {
          'activityId' =>  activity.id,
          'agent' => agent.serialize(version).to_json
      }
      query_params['registration'] = registration if registration
      get_profile_keys('activities/state', query_params)
    end

    def retrieve_state(id, activity, agent, registration)
      # TODO: Complete this
      query_params = {
          'stateId' => id,
          'activityId' => activity.id,
          'agent' => agent.serialize(version).to_json
      }
      document = StateDocument.new do |sd|
        sd.id = id
        sd.activity = activity
        sd.agent = agent
      end
      lrs_response = get_document('activities/state', query_params, document)
      if lrs_response.status == 200
        lrs_response.content = document
      end
      lrs_response
    end

    def save_state(state)
      # TODO: Complete this
      query_params = {
          'stateId' => state.id,
          'activityId' => state.activity.id,
          'agent' => state.agent.serialize(version).to_json
      }
      save_document('activities/state', query_params, state)
    end

    def delete_state(state)
      # TODO: Complete this
      query_params = {
          'stateId' => state.id,
          'activityId' => state.activity.id,
          'agent' => state.agent.serialize(version).to_json
      }
      query_params['registration'] = state.registration if state.registration
      delete_document('activities/state', query_params)
    end

    def clear_state(activity, agent, registration)
      # TODO: Complete this
      query_params = {
          'activityId' => activity.id,
          'agent' => agent.serialize(version).to_json
      }
      query_params['registration'] = registration if registration
      delete_document('activities/state', query_params)
    end

    def retrieve_activity_profile_ids(activity)
      # TODO: Complete this
      query_params = {
          'activityId' => activity.id
      }
      get_profile_keys('activities/profile', query_params)
    end

    def retrieve_activity_profile(id, activity)
      # TODO: Complete this
      query_params = {
          'profileId' => id,
          'activityId' => activity.id,
      }
      document = ActivityProfileDocument.new do |apd|
        apd.id = id
        apd.activity = activity
      end
      lrs_response = get_document('activities/profile', query_params, document)
      if lrs_response.status == 200
        lrs_response.content = document
      end
      lrs_response
    end

    def save_activity_profile(profile)
      # TODO: Complete this
      query_params = {
          'profileId' => profile.id,
          'activityId' => profile.activity.id,
      }
      save_document('activities/profile', query_params, profile)
    end

    def delete_activity_profile(profile)
      # TODO: Complete this
      query_params = {
          'profileId' => profile.id,
          'activityId' => profile.activity.id,
      }
      delete_document('activities/profile', query_params)
    end

    def retrieve_agent_profile_ids(agent)
      # TODO: Complete this
      query_params = {
          'agent' => agent.serialize(version).to_json
      }
      get_profile_keys('agents/profile', query_params)
    end

    def retrieve_agent_profile(id, agent)
      # TODO: Complete this
      query_params = {
          'profileId' => id,
          'agent' => agent.serialize(version).to_json
      }
      document = AgentProfileDocument.new do |apd|
        apd.id = id
        apd.agent = agent
      end
      lrs_response = get_document('agents/profile', query_params, document)
      if lrs_response.status == 200
        lrs_response.content = document
      end
      lrs_response
    end

    def save_agent_profile(profile)
      # TODO: Complete this
      query_params = {
          'profileId' => profile.id,
          'agent' => profile.agent.serialize(version).to_json
      }
      save_document('agents/profile', query_params, profile)
    end

    def delete_agent_profile(profile)
      # TODO: Complete this
      query_params = {
          'profileId' => profile.id,
          'agent' => profile.agent.serialize(version).to_json
      }
      delete_document('agents/profile', query_params)
    end

    private

    def setup_options(options={})
      options.each_pair do |key, value|
        if value && VALID_PARAMS.include?(key.to_s)
          instance_variable_set("@#{key}", value)
        end
      end
    end

    def yield_or_eval(&block)
      return unless block
      block.arity < 1 ? instance_eval(&block) : block[self]
    end

    def uri
      @uri ||= Addressable::URI.parse(end_point)
    end

    def path
      @path ||= uri.path
      @path += '/' unless @path.end_with?('/')
      @path
    end

    def connection
      base_url = "#{uri.scheme}://#{uri.host}"
      base_url = "#{base_url}:#{uri.port}" if uri.port
      @connection ||= Faraday.new(:url => base_url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.headers['X-Experience-API-Version'] = version.to_s
        faraday.basic_auth(user_name, password)
      end
    end

    def get_statement(id, parameter)
      response = connection.get do |req|
        req.url("#{path}statements")
        req.headers['Content-Type'] = 'application/json'
        req.params.merge!({parameter => id})
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status== 200
          lrs.content = Statement.new(json: response.body)
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def get_document(resource, params, document)
      response = connection.get do |req|
        req.url("#{path}#{resource}")
        req.params.merge!(params)
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status == 200
          lrs.success = true
          # TODO FIX THIS
        elsif response.status == 404
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def delete_document(resource, params)
      response = connection.delete do |req|
        req.url("#{path}#{resource}")
        req.params.merge!(params)
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status == 204
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def save_document(resource, params, document)
      # TODO: Complete this
      response = connection.put do |req|
        req.url("#{path}#{resource}")
        req.headers['Content-Type'] = 'application/json'
        req.headers['If-Match'] = document.etag if document.etag
        req.params.merge!(params)
        req.body = document.content
      end
      LrsResponse.new do |lrs|
        lrs.status = response.status
        if response.status == 204
          lrs.success = true
        else
          lrs.success = false
        end
      end
    end

    def get_profile_keys(resource, params)
      # TODO FIX THIS
      connection.get do |req|
        req.url("#{path}#{resource}")
        req.params.merge!(params)
      end
    end
  end
end