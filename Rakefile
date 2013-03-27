#!/usr/bin/env rake

require "bundler/gem_tasks"

require 'rake'
require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

task :default => :test
