# encoding: utf-8
require 'spec_helper'

describe TinCanApi::RemoteLRS do
  include Helpers

  describe 'about' do
    it 'is successful' do
      stub_request(:get, "http://user:password@www.example.com/about").
          with(headers: default_request_headers).
          to_return(
              status: 200,
              body: fixture('about.json'),
              headers: {})

      remote_lrs = TinCanApi::RemoteLRS.new do |c|
        c.end_point = 'http://www.example.com'
        c.user_name = 'user'
        c.password = 'password'
      end

      response = remote_lrs.about
      expect(response.success).to be(true)
    end

    it 'creates an about instance' do
      stub_request(:get, "http://user:password@www.example.com/about").
          with(headers: default_request_headers).
          to_return(
              status: 200,
              body: fixture('about.json'),
              headers: {})

      remote_lrs = TinCanApi::RemoteLRS.new do |c|
        c.end_point = 'http://www.example.com'
        c.user_name = 'user'
        c.password = 'password'
      end

      response = remote_lrs.about
      expect(response.content).to be_a(TinCanApi::About)
    end
  end
end