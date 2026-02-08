module GOVUKDesignSystemFormBuilder
  module Elements
    module Inputs
      class Text < Base
        include Traits::Input
        include Traits::Error
        include Traits::Hint
        include Traits::Label
        include Traits::Supplemental
        include Traits::HTMLAttributes
        include Traits::ContentBeforeAndAfter

      private

        def builder_method
          :text_field
        end
      end
    end
  end
end
