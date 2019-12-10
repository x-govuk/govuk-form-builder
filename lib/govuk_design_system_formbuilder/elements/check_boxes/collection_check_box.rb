module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class CollectionCheckBox < Base
        include Traits::CollectionItem
        include Traits::Hint

        def initialize(builder, object_name, attribute_name, checkbox, hint_method = nil, link_errors: false)
          super(builder, object_name, attribute_name)

          @checkbox  = checkbox
          @item      = checkbox.object
          @value     = checkbox.value
          @hint_text = retrieve(@item, hint_method)
          @link_errors = link_errors
        end

        def html
          content_tag('div', class: 'govuk-checkboxes__item') do
            safe_join(
              [
                @checkbox.check_box(
                  id: field_id(link_errors: @link_errors),
                  class: "govuk-checkboxes__input",
                  aria: { describedby: hint_id }
                ),
                label_element.html,
                hint_element.html
              ]
            )
          end
        end

      private

        def label_element
          @label_element ||= Label.new(@builder, @object_name, @attribute_name, @checkbox, value: @value, link_errors: @link_errors)
        end

        def hint_element
          @hint_element ||= Hint.new(@builder, @object_name, @attribute_name, @hint_text, value: @value)
        end
      end
    end
  end
end
