module GOVUKDesignSystemFormBuilder
  module Traits
    module Error
      def error_id
        return unless has_errors?

        build_id('error')
      end

    private

      def error_element
        @error_element ||= Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)
      end
    end
  end
end
