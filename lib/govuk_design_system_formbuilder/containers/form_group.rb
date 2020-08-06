module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      def initialize(builder, object_name, attribute_name, classes: nil, **kwargs)
        super(builder, object_name, attribute_name)

        @classes       = classes
        @extra_options = kwargs
      end

      def html
        tag.div(class: classes, **@extra_options) { yield }
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
