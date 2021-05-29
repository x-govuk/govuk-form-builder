module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class FieldsetCheckBox < Base
        include Traits::Label
        include Traits::Hint
        include Traits::HTMLAttributes
        include Traits::FieldsetItem

        def initialize(builder, object_name, attribute_name, value, unchecked_value, label:, hint:, link_errors:, multiple:, **kwargs, &block)
          super(builder, object_name, attribute_name)

          @value           = value
          @unchecked_value = unchecked_value
          @label           = label
          @hint            = hint
          @multiple        = multiple
          @link_errors     = link_errors
          @html_attributes = kwargs

          conditional_content(&block)
        end

      private

        def input_type
          :checkboxes
        end

        def input
          @builder.check_box(@attribute_name, attributes(@html_attributes), @value, @unchecked_value)
        end

        def fieldset_options
          { checkbox: true }
        end
      end
    end
  end
end
