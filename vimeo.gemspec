# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vimeo}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Hooks"]
  s.date = %q{2009-04-21}
  s.description = %q{A full featured Ruby implementation of the Vimeo API.}
  s.email = %q{matthooks@gmail.com}
  s.extra_rdoc_files = [
    "CHANGELOG.rdoc",
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG.rdoc",
    "README.rdoc",
    "VERSION.yml",
    "lib/vimeo.rb",
    "lib/vimeo/advanced.rb",
    "lib/vimeo/advanced/auth.rb",
    "lib/vimeo/advanced/base.rb",
    "lib/vimeo/advanced/contact.rb",
    "lib/vimeo/advanced/group.rb",
    "lib/vimeo/advanced/person.rb",
    "lib/vimeo/advanced/test.rb",
    "lib/vimeo/advanced/upload.rb",
    "lib/vimeo/advanced/video.rb",
    "lib/vimeo/simple.rb",
    "lib/vimeo/simple/activity.rb",
    "lib/vimeo/simple/album.rb",
    "lib/vimeo/simple/base.rb",
    "lib/vimeo/simple/channel.rb",
    "lib/vimeo/simple/clip.rb",
    "lib/vimeo/simple/group.rb",
    "lib/vimeo/simple/user.rb",
    "test/test_helper.rb",
    "test/vimeo_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/matthooks/vimeo}
  s.rdoc_options = ["--main", "README.rdoc", "--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A full featured Ruby implementation of the Vimeo API.}
  s.test_files = [
    "test/test_helper.rb",
    "test/vimeo_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
    else
      s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
    end
  else
    s.add_dependency(%q<jnunemaker-httparty>, [">= 0.2.6"])
  end
end
