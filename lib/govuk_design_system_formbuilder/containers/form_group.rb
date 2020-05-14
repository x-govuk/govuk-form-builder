module GOVUKDesignSystemFormBuilder
  module Containers
    class FormGroup < Base
      using PrefixableArray

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
        %w(form-group).prefix(brand).tap do |classes|
          classes.push(%(#{brand}-form-group--error)) if has_errors?
        end
      end
    end
  end
end
