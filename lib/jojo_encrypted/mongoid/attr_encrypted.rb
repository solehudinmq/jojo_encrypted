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
              
              define_method("#{attribute}_decrypted") do
                self[:"#{attribute}_decrypted"]=value
              end
            end

            define_method(attribute) do
              byebug
              # if self.new_record?

              # else

              # end
              # self[attribute] = self[attribute]
              # self["#{attribute}_decrypted".to_sym] = JojoEncrypted::Mongoid::Services::EncryptionService.decrypt(self[attribute])
            end
          end
        end
      end
    end
  end
end