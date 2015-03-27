# encoding: utf-8
require 'tin_can_api/tcapi_version'
module TinCanApi
  # Class used to communicate with a TCAPI endpoint synchronously
  class RemoteLRS
    include TinCanApi::TCAPIVersion

    attr_accessor :end_point, :user_name, :password, :version

    def initialize(version=V101)
      @version = version
    end

  end
end