require "jojo_encrypted/version"
require "jojo_encrypted/mongoid/services/encryption_service"
require "jojo_encrypted/mongoid/attr_encrypted"

module JojoEncrypted
  class Error < StandardError; end
  # Your code goes here... 

  YAML.load_file("config/jojo_encrypted.yml").each do |key, value|
    ENV[key] = value
  end
end
