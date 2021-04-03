module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class FieldsetRadioButton < Base
        using PrefixableArray

        include Traits::Label
        include Traits::Hint
        include Traits::FieldsetItem
        include Traits::Conditional
        include Traits::HTMLAttributes

        def initialize(builder, object_name, attribute_name, value, label:, hint:, link_errors:, **kwargs, &block)
          super(builder, object_name, attribute_name)

          @value           = value
          @label           = label
          @hint            = hint
          @link_errors     = has_errors? && link_errors
          @html_attributes = kwargs

          if block_given?
            @conditional_content = wrap_conditional(block)
            @conditional_id      = conditional_id
          end
        end

        def html
          safe_join([radio, @conditional_content])
        end

      private

        def radio
          tag.div(class: %(#{brand}-radios__item)) do
            safe_join([input, label_element, hint_element])
          end
        end

        def fieldset_options
          { radio: true }
        end

        def input
          @builder.radio_button(@attribute_name, @value, **attributes(@html_attributes))
        end

        def options
          {
            id: field_id(link_errors: @link_errors),
            aria: { describedby: [hint_id] },
            data: { 'aria-controls' => @conditional_id },
            class: %w(radios__input).prefix(brand)
          }
        end

        def conditional_classes
          %w(radios__conditional radios__conditional--hidden).prefix(brand)
        end
      end
    end
  end
end
