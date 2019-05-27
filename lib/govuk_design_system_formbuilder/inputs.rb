module GOVUKDesignSystemFormBuilder
  module Inputs
    def govuk_text_field(attribute_name, field_type: 'text', label: nil, hint: nil, width: 'full', label_weight: 'regular', label_size: 'regular')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width,
        label_weight: label_weight,
        label_size: label_size
      )
    end

    def govuk_tel_field(attribute_name, field_type: 'tel', label: nil, hint: nil, width: 'full', label_weight: 'regular', label_size: 'regular')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: label,
        hint: hint,
        width: width,
        label_weight: label_weight,
        label_size: label_size
      )
    end

  private

    def govuk_generic_text_field(attribute_name, field_type:, label: nil, hint: nil, width:, label_weight:, label_size:)
      content_tag('div', class: 'govuk-form-group') do
        safe_join([

          govuk_label(
            attribute_name,
            label,
            label_weight: label_weight,
            label_size: label_size
          ),

          hint.presence && govuk_hint(attribute_name, hint),

          tag.input(
            class: 'govuk-input',
            type: field_type,
            name: attribute_identifier(attribute_name),
            aria: {
              describedby: hint.presence && hint_id(attribute_name)
            }
          )
        ])
      end
    end
  end
end
