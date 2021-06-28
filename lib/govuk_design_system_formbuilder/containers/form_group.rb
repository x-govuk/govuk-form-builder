module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      def initialize(builder, object_name, attribute_name, classes: nil, **kwargs)
        super(builder, object_name, attribute_name)

        @classes         = classes
        @html_attributes = kwargs
      end

      def html(&block)
        tag.div(class: classes, **@html_attributes, &block)
      end

    private

      def classes
        combine_references(form_group_class, error_class, custom_classes)
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
