$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "resas/api"

RSpec.configure do | config |
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
