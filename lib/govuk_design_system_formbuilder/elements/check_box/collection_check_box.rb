module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBox
      class CollectionCheckBox < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, checkbox, value_method, text_method, hint_method = nil)
          @builder  = builder
          @checkbox = checkbox
          @item     = checkbox.object
          @value    = @item.send(value_method)
          @text     = @item.send(text_method)
          @hint     = @item.send(hint_method) if hint_method.present?
        end

        def html
          @builder.content_tag('div', class: 'govuk-checkboxes__item') do
            @builder.safe_join(
              [
                @checkbox.check_box(class: "govuk-checkboxes_input"),
                @checkbox.label(class: 'govuk-label govuk-checkboxes__label'),
                @builder.tag.span(@hint, class: 'govuk-hint govuk-checkboxes__hint')
              ]
            )
          end
        end
      end
    end
  end
end
