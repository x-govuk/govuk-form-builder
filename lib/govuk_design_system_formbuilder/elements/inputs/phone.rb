module GOVUKDesignSystemFormBuilder
  module Elements
    module Inputs
      class Phone < Base
        include Traits::Input
        include Traits::Error
        include Traits::Hint
        include Traits::Label
        include Traits::Supplemental
        include Traits::HTMLAttributes

        def builder_method
          :phone_field
        end
      end
    end
  end
end
