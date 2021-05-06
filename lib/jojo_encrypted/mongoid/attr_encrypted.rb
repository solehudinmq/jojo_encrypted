module JojoEncrypted
  module Mongoid
    module AttrEncrypted
      extend ActiveSupport::Concern

      class_methods do
        def encrypts(*attributes)
          attributes.each do |attribute|
            define_method("#{attribute}=".to_sym) do |value|
              return unless value

              self[attribute] = JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(value)
            end

            define_method(attribute) do
              self[attribute] = self[attribute]
            end

            define_method("#{attribute}_decrypted") do
              self["#{attribute}_decrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(self[attribute])
            end
          end
        end
      end
    end
  end
end