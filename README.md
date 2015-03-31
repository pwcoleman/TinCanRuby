# TinCanApi

A Ruby library for implementing Tin Can API (Experience API).

For more information about the Tin Can API visit:

http://tincanapi.com/

## Warning

Please regard this as alpha software. It was created to solve an urgent problem and has not been fully tested in a live environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tin_can_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tin_can_api

## Usage

Create a client using basic auth
```ruby
client = TinCanApi::Client.new do |c|
  c.end_point = 'https://some.endpoint.com'
  c.user_name = 'user'
  c.password = 'password'
end
```

Connect to the 'about' endpoint to get version information

```ruby
# use the client from above
response = client.about
# check if it is successful
if response.success
    # access the TinCanApi::About instance
    response.content
end
```

Create a statement

```ruby
agent = TinCanApi::Agent.new(mbox: 'mailto:info@tincanapi.com')
verb = TinCanApi::Verb.new(id: 'http://adlnet.gov/expapi/verbs/attempted')
activity = TinCanApi::Activity.new(id: 'http://pwcoleman.github.com/TinCanRuby')

statement = TinCanApi::Statement.new do |s|
  s.actor = agent
  s.verb = verb
  s.object = activity
end

response = client.save_statement(statement)
if response.success
  # access the statement
  response.content
end
```

For more API calls check out the TinCanApi::Client class

