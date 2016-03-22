# encoding: utf-8
# Style tests. Rubocop and Foodcritic
namespace :style do
  begin
    require 'rubocop/rake_task'
    desc 'Run Ruby style checks'
    RuboCop::RakeTask.new(:ruby)
  rescue LoadError
    puts '>>>>> Rubocop gem not loaded, omitting tasks' unless ENV['CI']
  end

  begin
    require 'foodcritic'

    desc 'Run Chef style checks'
    FoodCritic::Rake::LintTask.new(:chef) do |t|
      t.options = {
        fail_tags: ['any']
      }
    end
  rescue LoadError
    puts '>>>>> foodcritic gem not loaded, omitting tasks' unless ENV['CI']
  end
end
# Alias
task style: ['style:chef', 'style:ruby']

# Integration tests. Kitchen.ci

namespace :integration do
  desc 'Run test-kitchen in circleci context (docker)'
  task :circleci do
    @loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.circleci.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end

  begin
    require 'kitchen/rake_tasks'

    desc 'Run kitchen integration tests'
    Kitchen::RakeTasks.new
  rescue
    puts '>>>>> Kitchen gem not loaded, omitting tasks' # unless ENV['CI']
  end
end
# Alias
task integration: ['integration:kitchen:all']

# Unit tests with rspec/chefspec
namespace :unit do
  begin
    require 'rspec/core/rake_task'
    require 'ci/reporter/rake/rspec'
    desc 'Run unit tests with RSpec/ChefSpec and CI Reporter'
    # rspec for CI testing
    RSpec::Core::RakeTask.new('rspec:ci' => 'ci:setup:rspec') do |t|
      t.rspec_opts = '--format documentation'
    end
    desc 'Run unit tests with RSpec/ChefSpec and console logging'
    # Same thing but for command line output
    RSpec::Core::RakeTask.new('rspec') do |t|
      t.rspec_opts = [].tap do |a|
        a.push('--color')
        a.push('--format documentation')
      end.join(' ')
    end
  rescue LoadError
    puts '>>>>> rspec gem not loaded, omitting tasks' unless ENV['CI']
  end
end

desc 'Run full test stack'
task test: ['style', 'unit:rspec:ci', 'integration:kitchen:all']

desc 'Run full test stack on circleci'
task testci: ['style', 'unit:rspec:ci', 'integration:circleci']

task default: %w(style unit:rspec:ci)
