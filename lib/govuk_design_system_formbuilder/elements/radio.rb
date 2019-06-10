module GOVUKDesignSystemFormBuilder
  module Elements
    class FieldsetRadio < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, value, label: {}, hint: {})
        super(builder, object_name, attribute_name)
        @value = value
      end

      def html
        @builder.content_tag('div', class: 'govuk-radios__item') do
          @builder.radio_button(
            @attribute_name,
            @value,
            id: attribute_descriptor,
            aria: { describedby: hint_id }
          )
        end
      end
    end

    class CollectionRadio < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, item, value_method, text_method, hint_method, **args)
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
                aria: { describedby: hint_id }
              ),
              Elements::Label.new(@builder, @object_name, @attribute_name, text: @text, value: @value).html,
              Elements::Hint.new(@builder, @object_name, @attribute_name, id: hint_id, class: radio_hint_classes, text: @hint).html,
            ].compact
          )
        end
      end

    private

      def hint_id
        return nil unless @hint.present?

        [@object_name, @attribute_name, @value, 'hint'].join('-').parameterize
      end

      def radio_hint_classes
        %w(govuk-hint govuk-radios__hint)
      end
    end
  end
end
