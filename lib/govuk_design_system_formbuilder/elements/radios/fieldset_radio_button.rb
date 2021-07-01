module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class FieldsetRadioButton < Base
        include Traits::Label
        include Traits::Hint
        include Traits::HTMLAttributes
        include Traits::FieldsetItem

        def initialize(builder, object_name, attribute_name, value, label:, hint:, link_errors:, **kwargs, &block)
          super(builder, object_name, attribute_name, &block)

          @value           = value
          @label           = label
          @hint            = hint
          @link_errors     = has_errors? && link_errors
          @html_attributes = kwargs

          conditional_content(@block_content)
        end

      private

        def input_type
          :radios
        end

        def input
          @builder.radio_button(@attribute_name, @value, **attributes(@html_attributes))
        end

        def fieldset_options
          { radio: true }
        end
      end
    end
  end
end
