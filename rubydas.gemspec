# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubydas"
require "rubygems"

Gem::Specification.new do |s|
  s.name        = "intermine"
  s.version     = RubyDAS::VERSION
  s.authors     = ["Alex Kalderimis", "Bastian Greshake"]
  s.email       = ["alex@intermine.org", "bgreshake@googlemail.com"]
  s.summary     = %q{Ruby DAS server}
  s.description = File.new('README').read
  s.add_dependency "bio"
  s.add_dependency "data_mapper"
  s.add_dependency "sinatra"

  s.require_paths = ["lib"]
  s.test_file     = "test/test.rb"
  s.files         = `git ls-files -- lib/*`.split("\n") + `git ls-files -- test/*`.split("\n") + Dir['[A-Z]*'] + ["contact_header.rdoc"]
  s.license       = 'LGPL'
end
