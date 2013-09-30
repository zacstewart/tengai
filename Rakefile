STDOUT.sync = true
require 'rake/testtask'
require 'rspec/core/rake_task'

task default: :spec

RSpec::Core::RakeTask.new(:spec)

namespace :ragel do
  targets = %w(vector_ephemeris_parser body_data_sheet_parser)

  desc 'Compiles the Ragel state machine definitions to Ruby'
  task :compile do
    Rake::Task['ragel:clean'].invoke
    targets.each do |target|
      puts "Compiling #{target}"
      sh "ragel -R ext/horizons/#{target}.rl"
      raise "Failed to compile #{target}" unless File.exists? "ext/horizons/#{target}.rb"
    end
  end

  desc 'Removes compiled Ragel state machines'
  task :clean do
    targets.each do |target|
      puts "Removing #{target}"
      File.unlink "ext/horizons/#{target}.rb" if File.exists? "ext/horizons/#{target}.rb"
    end
  end
end
