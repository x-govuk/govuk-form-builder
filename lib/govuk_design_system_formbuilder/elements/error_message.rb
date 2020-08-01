module GOVUKDesignSystemFormBuilder
  module Elements
    class ErrorMessage < Base
      using PrefixableArray

      include Traits::Error

      def initialize(builder, object_name, attribute_name)
        super(builder, object_name, attribute_name)
      end

      def html
        return nil unless has_errors?

        tag.span(class: %(#{brand}-error-message), id: error_id) do
          safe_join([hidden_prefix, message])
        end
      end

    private

      def hidden_prefix
        tag.span('Error: ', class: %(#{brand}-visually-hidden))
      end

      def message
        @builder.object.errors.messages[@attribute_name]&.first
      end
    end
  end
end
