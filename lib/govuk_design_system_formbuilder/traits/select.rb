module GOVUKDesignSystemFormBuilder
  module Traits
    module Select
    private

      def classes
        [%(#{brand}-select), error_class].flatten.compact
      end

      def error_class
        %(#{brand}-select--error) if has_errors?
      end
    end
  end
end
