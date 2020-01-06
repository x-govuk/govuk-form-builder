module GOVUKDesignSystemFormBuilder
  module Elements
    class ErrorMessage < Base
      include Traits::Error

      def initialize(builder, object_name, attribute_name)
        super(builder, object_name, attribute_name)
      end

      def html
        return unless has_errors?

        content_tag('span', class: 'govuk-error-message', id: error_id) do
          safe_join(
            [
              tag.span('Error: ', class: 'govuk-visually-hidden'),
              message
            ]
          )
        end
      end

      def message
        @builder.object.errors.messages[@attribute_name]&.first
      end
    end
  end
end
