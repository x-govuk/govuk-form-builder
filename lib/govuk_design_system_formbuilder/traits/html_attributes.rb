module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      using HTMLAttributesUtils

      def attributes(html_attributes = {})
        options
          .deep_merge_html_attributes(html_attributes)
          .deep_tidy_html_attributes
      end
    end
  end
end
