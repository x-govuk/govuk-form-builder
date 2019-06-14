module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name)
        super(builder, object_name, attribute_name)
      end

      def html
        @builder.content_tag('div', class: form_group_classes) do
          yield
        end
      end

    private

      def form_group_classes
        %w(govuk-form-group).push(form_group_error_classes).compact
      end

      def form_group_error_classes
        return nil unless has_errors?

        'govuk-form-group--error'
      end
    end
  end
end
