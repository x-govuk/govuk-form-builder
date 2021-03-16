module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      def attributes(html_attributes = {})
        options.deep_merge(html_attributes)
      end
    end
  end
end
