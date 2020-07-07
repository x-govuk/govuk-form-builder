module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      def initialize(builder, object_name, attribute_name, classes: nil)
        super(builder, object_name, attribute_name)

        @classes = classes
      end

      def html
        content_tag('div', class: classes) { yield }
      end

    private

      def classes
        [form_group_class, error_class, custom_classes].flatten.compact
      end

      def form_group_class
        %(#{brand}-form-group)
      end

      def error_class
        %(#{brand}-form-group--error) if has_errors?
      end

      def custom_classes
        Array.wrap(@classes)
      end
    end
  end
end
