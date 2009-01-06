# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vimeo}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Hooks"]
  s.date = %q{2009-01-06}
  s.description = %q{A full featured Ruby implementation of the Vimeo API.}
  s.email = %q{matthooks@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE", "CHANGELOG.rdoc"]
  s.files = ["README.rdoc", "LICENSE", "CHANGELOG.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/matthooks/vimeo}
  s.rdoc_options = ["--main", "README.rdoc", "--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A full featured Ruby implementation of the Vimeo API.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
    else
      s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
    end
  else
    s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
  end
end
