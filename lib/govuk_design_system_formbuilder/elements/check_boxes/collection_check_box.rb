module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class CollectionCheckBox < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, attribute, checkbox, hint_method = nil)
          @builder   = builder
          @attribute = attribute
          @checkbox  = checkbox
          @item      = checkbox.object
          @hint_text = @item.send(hint_method) if hint_method.present?
        end

        def html
          hint = Hint.new(@builder, @attribute, @checkbox, @hint_text)
          @builder.content_tag('div', class: 'govuk-checkboxes__item') do
            @builder.safe_join(
              [
                @checkbox.check_box(class: "govuk-checkboxes__input", aria: { describedby: hint.id }),
                Label.new(@checkbox).html,
                hint.html
              ]
            )
          end
        end
      end
    end
  end
end
