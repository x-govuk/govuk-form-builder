module GOVUKDesignSystemFormBuilder
  module Traits
    module Error
      def error_element
        @error_element ||= Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)
      end

      def error_id
        return nil unless has_errors?

        build_id('error')
      end
    end
  end
end
