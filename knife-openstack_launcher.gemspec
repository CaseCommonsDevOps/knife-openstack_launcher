# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-openstack_launcher/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-openstack_launcher"
  spec.version       = Knife::OpenstackLauncher::VERSION
  spec.authors       = ["Stephane Jourdan", "Greg Karékinian"]
  spec.email         = ["sjourdan@greenalto", "greg@greenalto.com"]
  spec.description   = %q{A knife-openstack wrapper with support for YAML profiles}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/greenalto/knife-openstack_launcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  chef_version = if ENV.key?('CHEF_VERSION')
                   "= #{ENV['CHEF_VERSION']}"
                 else
                   ['>= 10', '<= 12']
                 end
  spec.add_dependency "knife-openstack", "~> 0.9.0"
  spec.add_dependency "chef",      chef_version

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake",    "~> 10.1.0"
  spec.add_development_dependency "rspec",   "~> 2.14.1"
  spec.add_development_dependency "guard-rspec"
end
