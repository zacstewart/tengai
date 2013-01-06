STDOUT.sync = true
require 'rake/testtask'

task default: :test
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
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
