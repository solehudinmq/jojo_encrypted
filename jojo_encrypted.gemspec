
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'active_support'
require 'yaml'

YAML.load_file("config/jojo_encrypted.yml").each do |key, value|
  ENV[value] = value
end

require "jojo_encrypted/version"
require "jojo_encrypted/mongoid/services/encryption_service"
require "jojo_encrypted/mongoid/attr_encrypted"

Gem::Specification.new do |spec|
  spec.name          = "jojo_encrypted"
  spec.version       = JojoEncrypted::VERSION
  spec.authors       = ["solehudinMQ"]
  spec.email         = ["solehudinmq@gmail.com"]

  spec.summary       = %q{Simple field encryption}
  spec.description   = %q{Simple field encryption for rails project}
  spec.homepage      = "http://example.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "http://example.com"
    spec.metadata["changelog_uri"] = "http://example.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 11.1.3"

  spec.add_dependency "activesupport", '~> 6.1', ">= 6.1.3.2"
end
