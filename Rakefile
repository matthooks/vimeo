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
    gem.add_development_dependency "thoughtbot-shoulda"
    gem.add_development_dependency "fakeweb"
    
    # s.files = FileList["[A-Z]*.*", "{bin,generators,lib,test,spec}/**/*"]
    # 
    # s.has_rdoc = true
    # s.rdoc_options = ['--main', 'README.rdoc']
    # s.rdoc_options << '--inline-source' << '--charset=UTF-8'
    # s.extra_rdoc_files = ['README.rdoc', 'LICENSE', 'CHANGELOG.rdoc']
    
    gem.add_dependency "httparty", ">= 0.4.5"
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
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
