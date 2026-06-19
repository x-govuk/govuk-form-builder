module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      include Traits::HTMLAttributes
      include Traits::HTMLClasses

      def initialize(builder, object_name, attribute_name, **kwargs)
        super(builder, object_name, attribute_name)

        @html_attributes = kwargs
      end

      def html(&block)
        tag.div(**attributes(@html_attributes), &block)
      end

    private

      def options
        {
          class: build_classes(
            %(#{brand}-form-group),
            %(#{brand}-form-group--error) => has_errors?
          )
        }
      end
    end
  end
end
