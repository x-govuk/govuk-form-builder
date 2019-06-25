module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class CollectionRadio < Radio
        def initialize(builder, object_name, attribute_name, item, value_method, text_method, hint_method)
          super(builder, object_name, attribute_name)
          @item = item
          @value = item.send(value_method)
          @text = item.send(text_method)
          @hint = item.send(hint_method) if hint_method.present?
        end

        def html
          @builder.content_tag('div', class: 'govuk-radios__item') do
            @builder.safe_join(
              [
                @builder.radio_button(
                  @attribute_name,
                  @value,
                  id: attribute_descriptor,
                  aria: { describedby: hint_id },
                  class: %w(govuk-radios__input)
                ),
                Elements::Label.new(@builder, @object_name, @attribute_name, text: @text, value: @value).html,
                Elements::Hint.new(@builder, @object_name, @attribute_name, id: hint_id, class: radio_hint_classes, text: @hint).html,
              ].compact
            )
          end
        end
      end
    end
  end
end
