module Examples
  module TextInput
    def text_field
      "= f.govuk_text_field :name"
    end

    def text_field_with_label
      <<~SNIPPET
        = f.govuk_text_field :first_name,
          label: { text: 'First name' }
      SNIPPET
    end

    def text_field_with_hint
      <<~SNIPPET
        = f.govuk_text_field :last_name,
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
        = f.govuk_text_field :postcode, width: 'one-third'
      SNIPPET
    end
  end
end
