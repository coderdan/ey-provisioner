require File.expand_path("../../lib/ey-provisioner", __FILE__)

require 'active_support'
require 'active_support/core_ext/array/wrap'

require 'pry'
require 'mocha/api'
require 'shoulda'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.mock_with :mocha
end
