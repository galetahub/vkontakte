# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vkontakte/version"

Gem::Specification.new do |s|
  s.name = "vkontakte"
  s.version = Vkontakte::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.summary = "Vkontakte API"
  s.description = "The easiest way to access Vkontakte API and some other utils. "
  s.authors = ["Igor Galeta", "Pavlo Galeta"]
  s.email = "galeta.igor@gmail.com"
  s.homepage = "https://github.com/galetahub/vkontakte"
  
  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.test_files = Dir["{spec}/**/*"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.require_paths = ["lib"]
  
  s.add_dependency(%q<activesupport>, [">= 0"])
  s.add_dependency('httparty')
end
