require 'yaml'
require 'active_support/concern'
require 'active_support/key_generator'
require 'active_support/message_encryptor'
require 'active_support/core_ext/module/delegation'
require 'byebug'

require "jojo_encrypted/version"
require "jojo_encrypted/mongoid/services/encryption_service"
require "jojo_encrypted/mongoid/attr_encrypted"

module JojoEncrypted
  class Error < StandardError; end
  # Your code goes here... 

  YAML.load_file("config/jojo_encrypted.yml").each do |key, value|
    ENV[key.to_s] = value
  end
end
