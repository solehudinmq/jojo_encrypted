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
              byebug
              # return if self.new_record?

              self[attribute] = self[attribute]
              self["#{attribute}_encrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.encrypt(self[attribute])
            end
          end
        end
      end
    end
  end
end