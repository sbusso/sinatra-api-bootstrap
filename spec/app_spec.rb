require 'rspec_helper'

describe "Sinatra API" do

  it "should respond to GET /" do
    get '/'
    last_response.should be_ok
    last_response.body.should be_json({"message" => "Hello API"})
  end

  it "should respond to POST /" do
    post '/', message: "Hello API Post"
    last_response.should be_ok
    last_response.body.should be_json({"message" => "Hello API Post"})
  end


end