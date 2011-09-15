Gem::Specification.new do |s|
  s.name = %q{vimeo}
  s.version = "1.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Matt Hooks}]
  s.date = %q{2011-09-07}
  s.description = %q{A full featured Ruby implementation of the Vimeo API.}
  s.email = %q{matthooks@gmail.com}
  s.extra_rdoc_files = [
    "CHANGELOG.rdoc",
     "LICENSE"
  ]
  s.files = Dir['lib/**/**.rb'] + ["README.markdown", "CHANGELOG.rdoc", "init.rb"] + Dir['test/**/**']
  s.homepage = %q{http://github.com/matthooks/vimeo}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}, %q{--inline-source}, %q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{vimeo}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A full featured Ruby implementation of the Vimeo API.}
  s.test_files = Dir['test/**/**.rb']

  s.specification_version = 3
  
  s.add_runtime_dependency(%q<oauth>, [">= 0.4.3"])
  s.add_runtime_dependency(%q<multipart-post>, [">= 1.0.1"])
  
  s.add_development_dependency(%q<shoulda>, [">= 2.11.3"])
  s.add_development_dependency(%q<fakeweb>, [">= 1.2.6"])
  s.add_development_dependency(%q<activesupport>, [">= 3.0"])
  s.add_development_dependency(%q<yajl-ruby>, [">= 3.0"])
  s.add_development_dependency(%q<ruby-prof>, [">= 0.9.2"])
end

