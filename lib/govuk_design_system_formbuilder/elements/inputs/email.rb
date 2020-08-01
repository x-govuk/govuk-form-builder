module GOVUKDesignSystemFormBuilder
  module Elements
    module Inputs
      class Email < Base
        include Traits::Input
        include Traits::Error
        include Traits::Hint
        include Traits::Label
        include Traits::Supplemental

      private

        def builder_method
          :email_field
        end
      end
    end
  end
end
