require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rack/test'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  App
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

# Will accept either a Hash or a JSON string as the expected value. Use it like this:
#
# @response.body.should be_json({:my => {:expected => ["json","hash"]}})
# @response.body.should be_json('{"my":{"expected":["json","hash"]}}')

RSpec::Matchers.define :be_json do |expected|
  match do |actual|
    actual = ActiveSupport::JSON.decode(actual)
    expected = ActiveSupport::JSON.decode(expected) unless expected.is_a?(Hash)
    actual.diff(expected) == {}
  end
end

class Hash
  def diff(other)
    (self.keys + other.keys).uniq.inject({}) do |memo, key|
      unless self[key] == other[key]
        if self[key].kind_of?(Hash) &&  other[key].kind_of?(Hash)
          memo[key] = self[key].diff(other[key])
        else
          memo[key] = [self[key], other[key]]
        end
      end
      memo
    end
  end
end