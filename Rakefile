require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "vimeo"
    gem.summary = %Q{A full featured Ruby implementation of the Vimeo API.}
    gem.description = %Q{A full featured Ruby implementation of the Vimeo API.}
    gem.email = "matthooks@gmail.com"
    gem.homepage = "http://github.com/matthooks/vimeo"
    gem.authors = ["Matt Hooks"]
    gem.rubyforge_project = "vimeo"
    gem.add_development_dependency "thoughtbot-shoulda", ">= 2.10.2"
    gem.add_development_dependency "fakeweb", ">= 1.2.6"
    gem.add_development_dependency "crack", ">= 0.1.4"
    
    gem.has_rdoc = true
    
    gem.rdoc_options = ['--main', 'README.rdoc', '--inline-source', '--charset=UTF-8']
    gem.extra_rdoc_files = ['README.rdoc', 'LICENSE', 'CHANGELOG.rdoc']
    
    gem.add_dependency "httparty", ">= 0.4.5"
    gem.add_dependency "json", ">= 1.1.9"
    gem.add_dependency "oauth-client", ">= 0.1.0"
    gem.add_dependency "oauth", ">= 0.3.6"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "vimeo #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
