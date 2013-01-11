STDOUT.sync = true
require 'rake/testtask'

task default: :test

desc 'Run all tests'
task :test do
  Rake::Task['test:units'].invoke
  Rake::Task['test:integration'].invoke
end

namespace :test do
  desc 'Run all tests together (for coverage)'
  Rake::TestTask.new(:all) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end

  desc 'Run unit tests'
  Rake::TestTask.new(:units) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
  end

  desc 'Run integration tests'
  Rake::TestTask.new(:integration) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
  end
end

namespace :ragel do
  desc 'Compiles the Ragel state machine definitions to Ruby'
  task :compile do
    Rake::Task['ragel:clean'].invoke
    target = 'ephemeris_parser'
    puts "Compiling #{target}"
    sh "ragel -R ext/horizons/#{target}.rl"
    raise "Failed to compile #{target}" unless File.exists? "ext/horizons/#{target}.rb"
  end

  desc 'Removes compiled Ragel state machines'
  task :clean do
    target = 'ephemeris_parser'
    puts "Removing #{target}"
    File.unlink "ext/horizons/#{target}.rb"
  end
end
