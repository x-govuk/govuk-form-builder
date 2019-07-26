module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class CollectionCheckBox < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, object_name, attribute_name, checkbox, hint_method = nil, link_errors: false)
          super(builder, object_name, attribute_name)
          @checkbox  = checkbox
          @item      = checkbox.object
          @value     = checkbox.value
          @hint_text = @item.send(hint_method) if hint_method.present?
          @link_errors = link_errors
        end

        def html
          hint = Hint.new(@builder, @object_name, @attribute_name, hint_text: @hint_text, value: @value)

          @builder.content_tag('div', class: 'govuk-checkboxes__item') do
            @builder.safe_join(
              [
                @checkbox.check_box(id: field_id(link_errors: @link_errors), class: "govuk-checkboxes__input", aria: { describedby: hint.hint_id }),
                Label.new(@checkbox, @object_name, @attribute_name, value: @value).html,
                hint.html
              ]
            )
          end
        end
      end
    end
  end
end
