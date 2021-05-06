
require 'yaml'
require 'active_support/all'

module JojoEncrypted
  module Mongoid
    module Services
      class EncryptionService
        YAML.load_file("config/jojo_encrypted.yml").each do |key, value|
          ENV[key.to_s] = value
        end

        # how to generate 'ENCRYPTION_SERVICE_SALT' :
        # 1. irb
        # 2. require 'active_support'
        # 3. SecureRandom.random_bytes(
        #     ActiveSupport::MessageEncryptor.key_len
        #    )

        # how to generate 'SECRET_KEY_BASE' :
        # 1. irb
        # 2. require 'securerandom'
        # 3. SecureRandom.hex(64)
        KEY = ActiveSupport::KeyGenerator.new(
          ENV.fetch("SECRET_KEY_BASE")
        ).generate_key(
          ENV.fetch("ENCRYPTION_SERVICE_SALT"),
          ActiveSupport::MessageEncryptor.key_len
        ).freeze
      
        private_constant :KEY
        
        delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor
      
        def self.encrypt(value)
          new.encrypt_and_sign(value)
        end
      
        def self.decrypt(value)
          new.decrypt_and_verify(value)
        end
      
        private
      
        def encryptor
          ActiveSupport::MessageEncryptor.new(KEY)
        end
      end
    end
  end
end