module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      def initialize(builder, object_name, attribute_name)
        super(builder, object_name, attribute_name)
      end

      def html
        content_tag('div', class: classes) do
          yield
        end
      end

    private

      def classes
        [form_group_class, error_class].compact
      end

      def form_group_class
        %(#{brand}-form-group)
      end

      def error_class
        %(#{brand}-form-group--error) if has_errors?
      end
    end
  end
end
