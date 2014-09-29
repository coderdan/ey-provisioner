require File.expand_path("../../lib/ey-provisioner", __FILE__)

Dir[File.expand_path("../../spec/support/**/*.rb", __FILE__)].each {|f| require f}

require 'active_support'
require 'active_support/core_ext/array/wrap'

require 'pry'
require 'mocha/api'
require 'shoulda'
require 'shoulda/matchers'
require 'rspec/its'

RSpec.configure do |config|
  config.mock_with :mocha
end
