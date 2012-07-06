require 'yard'
require 'sinatra/activerecord/rake'
require './app'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['./**/*.rb', 'README']   # optional
  # t.options = ['--plugin sinatra'] # optional
end

require 'rspec/core/rake_task'

desc "run specs"
RSpec::Core::RakeTask.new