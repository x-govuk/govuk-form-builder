module GOVUKDesignSystemFormBuilder
  module Inputs
    def govuk_text_field(attribute_name, field_type: 'text', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: govuk_label_options(label),
        hint: govuk_hint_options(hint),
        width: width
      )
    end

    def govuk_tel_field(attribute_name, field_type: 'tel', label: {}, hint: {}, width: 'full')
      govuk_generic_text_field(
        attribute_name,
        field_type: field_type,
        label: govuk_label_options(label),
        hint: govuk_hint_options(hint),
        width: width
      )
    end

    def govuk_label_options(opts = {})
      govuk_label_defaults.merge(opts)
    end

    def govuk_hint_options(opts = {})
      if opts&.any?
        govuk_hint_defaults.merge(opts)
      else
        {}
      end
    end

  private

    def govuk_generic_text_field(attribute_name, field_type:, label: nil, hint: nil, width:)
      content_tag('div', class: 'govuk-form-group') do
        safe_join([
          govuk_label(attribute_name, label),

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
