module JojoEncrypted
  module Mongoid
    module AttrEncrypted
      extend ActiveSupport::Concern

      class_methods do
        def encrypts(*attributes)
          attributes.each do |attribute|
            # define_method("#{attribute}=".to_sym) do |value|
            #   return if value.nil?
              
            #   self.public_send(
            #     "encrypted_#{attribute}=".to_sym,
            #     JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(value)
            #   )
            # end

            # define_method(attribute) do
            #   value = self.public_send("encrypted_#{attribute}".to_sym)
            #   JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(value) if value.present?
            # end

            define_method("#{attribute}") do
              self[attribute]=JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(self[attribute])
            end

            define_method("#{attribute}_encrypted") do
              self[:"#{attribute}_encrypted"]=JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(self[attribute])
            end
          end
        end
      end
    end
  end
end