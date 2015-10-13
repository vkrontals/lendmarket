require 'bundler/setup'
Bundler.setup

require 'lendmarket'

RSpec.configure do |config|
  config.color = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
