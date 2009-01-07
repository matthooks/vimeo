require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "vimeo"
    s.summary = "A full featured Ruby implementation of the Vimeo API."
    s.email = "matthooks@gmail.com"
    s.homepage = "http://github.com/matthooks/vimeo"
    s.description = "A full featured Ruby implementation of the Vimeo API."
    s.authors = ["Matt Hooks"]

    s.files = FileList["[A-Z]*.*", "{bin,generators,lib,test,spec}/**/*"]

    s.has_rdoc = true
    s.rdoc_options = ['--main', 'README.rdoc']
    s.rdoc_options << '--inline-source' << '--charset=UTF-8'
    s.extra_rdoc_files = ['README.rdoc', 'LICENSE', 'CHANGELOG.rdoc']
    
    s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'vimeo'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :rcov
