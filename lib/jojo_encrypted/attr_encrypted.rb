require 'active_support/concern'

module JojoEncrypted
  module AttrEncrypted
    extend ActiveSupport::Concern

    class_methods do
      def encrypts(*attributes)
        attributes.each do |attribute|
          define_method("#{attribute}=".to_sym) do |value|
            return unless value

            self[attribute] = JojoEncrypted::Services::EncryptionService.encrypt(value)
          end

          define_method(attribute) do
            self[attribute]
          end

          define_method("#{attribute}_decrypted") do
            JojoEncrypted::Services::EncryptionService.decrypt(self[attribute])
          end
        end
      end

      # encrypts fields as temporary (encryptions is not save to db)
      def temporary_encrypts(*attributes)
        attributes.each do |attribute|
          define_method(attribute) do
            self[attribute]
          end

          define_method("#{attribute}_encrypted") do
            JojoEncrypted::Services::EncryptionService.encrypt(self[attribute])
          end
        end
      end
    end
  end
end