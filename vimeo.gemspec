# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vimeo}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Hooks"]
  s.date = %q{2008-12-29}
  s.description = %q{A full featured Ruby implementation of the Vimeo API.}
  s.email = %q{matthooks@gmail.com}
  s.homepage = %q{http://github.com/matthooks/vimeo}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A full featured Ruby implementation of the Vimeo API.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jnunemaker-httparty>, [">= 0.2.4"])
    else
      s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.4"])
    end
  else
    s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.4"])
  end
end
