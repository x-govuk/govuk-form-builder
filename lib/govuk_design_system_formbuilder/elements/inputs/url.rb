module GOVUKDesignSystemFormBuilder
  module Elements
    module Inputs
      class URL < Base
        include Traits::Input
        include Traits::Error
        include Traits::Hint
        include Traits::Label
        include Traits::Supplemental
        include Traits::HTMLAttributes

      private

        def builder_method
          :url_field
        end
      end
    end
  end
end
