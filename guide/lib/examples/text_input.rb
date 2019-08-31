module Examples
  module TextInput
    def text_field_with_label_and_hint
      <<~SNIPPET
        = f.govuk_text_field :first_name,
          label: { text: 'First name' },
          hint_text: 'You can find it on your birth certificate'
      SNIPPET
    end

    def text_field_with_attributes
      <<~SNIPPET
        = f.govuk_text_field :job_title,
          placeholder: "Nuclear safety engineer",
          autocomplete: "organization-title"
      SNIPPET
    end

    def text_field_with_custom_width
      <<~SNIPPET
        h3.govuk-heading-s Fractional widths

        = f.govuk_text_field :full,           width: 'full'
        = f.govuk_text_field :three_quarters, width: 'three-quarters'
        = f.govuk_text_field :one_half,       width: 'one-half'
        = f.govuk_text_field :one_third,      width: 'one-third'
        = f.govuk_text_field :one_quarter,    width: 'one-quarter'

        h3.govuk-heading-s Absolute (character) widths

        = f.govuk_text_field :twenty, width: 20
        = f.govuk_text_field :ten,    width: 10
        = f.govuk_text_field :five,   width: 5
        = f.govuk_text_field :four,   width: 4
        = f.govuk_text_field :three,  width: 3
        = f.govuk_text_field :two,    width: 2
      SNIPPET
    end
  end
end
