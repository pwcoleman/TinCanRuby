# encoding: utf-8
module TinCanApi
  # Statements result model class, returned by LRS calls to get multiple statements
  class StatementsResult

    attr_accessor :statements, :more_url

    def initialize(options={})
      json = options.fetch(:json, nil)
      self.statements = []
      if json
        self.statements = json['statements'].map {|statement| Statement.new(json: statement.to_json)} if json['statements']
        self.more_url = json['more'] if json['more']
      end
    end
  end
end
