module GOVUKDesignSystemFormBuilder
  module Traits
    module Select
    private

      def classes
        combine_references(%(#{brand}-select), error_class)
      end

      def error_class
        %(#{brand}-select--error) if has_errors?
      end
    end
  end
end
