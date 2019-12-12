module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      def initialize(builder, object_name, attribute_name)
        super(builder, object_name, attribute_name)
      end

      def html
        content_tag('div', class: form_group_classes) do
          yield
        end
      end

    private

      def form_group_classes
        %w(govuk-form-group).tap do |classes|
          classes.push('govuk-form-group--error') if has_errors?
        end
      end
    end
  end
end
