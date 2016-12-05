require "bundler/gem_tasks"
require "rspec/core/rake_task"

load File.expand_path( '../lib/resas/api/tasks/make_methods.rake', __FILE__ )
load File.expand_path( '../lib/resas/api/tasks/spec/endpoints.rake', __FILE__ )

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
