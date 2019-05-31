module GOVUKDesignSystemFormBuilder
  module Inputs
    def govuk_text_field(attribute_name, field_type: 'text', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

    def govuk_tel_field(attribute_name, field_type: 'tel', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width
      )
    end

  private

    def govuk_generic_text_field(attribute_name, field_type:, label: nil, hint: nil, width:)
      hint_element  = Hint.new(self, object_name, attribute_name, hint)
      label_element = Label.new(self, object_name, attribute_name, label)

      content_tag('div', class: 'govuk-form-group') do
        safe_join([

          label_element.html,
          hint_element.html,

          tag.input(
            class: 'govuk-input',
            type: field_type,
            name: label_element.attribute_identifier,
            aria: {
              describedby: hint_element.hint_id
            }
          )
        ])
      end
    end
  end
end
