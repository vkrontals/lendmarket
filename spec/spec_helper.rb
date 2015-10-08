require 'bundler/setup'
Bundler.setup

require 'lendmarket'

RSpec.configure do |config|
  config.color = true
  config.filter_run_including focus:  true
end
