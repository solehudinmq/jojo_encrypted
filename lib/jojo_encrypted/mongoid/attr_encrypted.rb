module JojoEncrypted
  module Mongoid
    module AttrEncrypted
      extend ActiveSupport::Concern

      class_methods do
        def encrypts(*attributes)
          attributes.each do |attribute|
            define_method("#{attribute}=".to_sym) do |value|
              return unless value

              # self[attribute] = JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(value)
              self["#{attribute}_encrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(value)
              self[attribute] = value
            end

            define_method(attribute) do
              byebug
              self[attribute] = JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(self[attribute])
              self["#{attribute}_encrypted".to_sym] = self[attribute]

              # value = self.public_send("encrypted_#{attribute}".to_sym)

              # JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(value) if value.present?
            end
          end
        end
      end
    end
  end
end