
require 'cucumber'
require 'cucumber/rake/task'

namespace :features do
  Cucumber::Rake::Task.new(:smoke) do |t|
    t.profile = 'qa_regression'
  end
  Cucumber::Rake::Task.new(:qa_smoke) do |t|
    t.profile = 'qa_smoke'
  end
  task :nightly_job => [:smoke, :qa_smoke]
end

task :default => :smoke
