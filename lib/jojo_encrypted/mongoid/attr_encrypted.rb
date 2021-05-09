require 'active_support/concern'

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

            # define_method(attribute) do
            #   self[attribute] = self[attribute]
            # end

            # unless self.new_record?
            #   define_method("#{attribute}_decrypted") do
            #     self["#{attribute}_decrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(self[attribute])
            #   end
            # end

            masking_fields(self, attribute)
          end
        end

        # encrypts fields as temporary (encryptions is not save to db)
        def temp_encrypts(*attributes)
          attributes.each do |attribute|
            # define_method(attribute) do
            #   self[attribute] = self[attribute]
            # end

            # unless self.new_record?
            #   define_method("#{attribute}_decrypted") do
            #     self["#{attribute}_decrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(self[attribute])
            #   end
            # end

            masking_fields(self, attribute)
          end
        end

        private
          def masking_fields(object_masking, attribute)
            define_method(attribute) do
              object_masking[attribute] = object_masking[attribute]
            end

            define_method("#{attribute}_decrypted") do
              object_masking["#{attribute}_decrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(object_masking[attribute]) unless object_masking.new_record?
            end
          end
      end
    end
  end
end