require 'yaml'

require "jojo_encrypted/version"
require "jojo_encrypted/services/encryption_service"
require "jojo_encrypted/attr_encrypted"

module JojoEncrypted
  class Error < StandardError; end
  # Your code goes here... 

  YAML.load_file("config/jojo_encrypted.yml").each do |key, value|
    ENV[key.to_s] = value
  end
end
