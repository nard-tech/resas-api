require 'active_support'
require 'active_support/core_ext'

namespace :spec do

  desc 'Run RSpec code examples only related to endpoints'
  task :endpoints do
    ENV[ 'SPEC' ] = "spec/resas/api/client_ext/endpoints/"
    Rake::Task[ 'spec' ].invoke
  end

end
