module JojoEncrypted
  module Mongoid
    module AttrEncrypted
      extend ActiveSupport::Concern

      class_methods do
        def encrypts(*attributes)
          attributes.each do |attribute|
            define_method("#{attribute}=".to_sym) do |value|
              return if value.nil?
              
              puts "SETTER ATTR : #{attribute}"
              puts "SETTER VALUE : #{value}"
              puts "SETTER SELF : #{self}"
              puts "SETTER GET VALUE : #{self[attribute.to_sym]}"

              self.public_send(
                "encrypted_#{attribute}=".to_sym,
                JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(value)
              )
            end

            define_method(attribute) do
              value = self.public_send("encrypted_#{attribute}".to_sym)

              puts "GETTER ATTR : #{attribute}"
              puts "GETTER VALUE : #{value}"

              JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(value) if value.present?
            end
          end
        end
      end
    end
  end
end