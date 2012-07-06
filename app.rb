require 'rubygems'
require 'bundler'

Bundler.require

require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader" if development?

class App < Sinatra::Base
  helpers Sinatra::JSON
  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    json "error" => "not Found"
  end

  def error(code, body)
    response.body = body
    halt code, {'Content-Type' => 'application/json'}, { error: body }.to_json
  end

  get "/" do
    json message: "Hello API"
  end

  post '/' do
    json message: params[:message]
  end


end