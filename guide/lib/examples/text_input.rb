module Examples
  module TextInput
    def text_field
      "f.govuk_text_field :name"
    end

    def text_field_with_label
      <<~SNIPPET
        f.govuk_text_field :name,
          label: { text: 'Full name' }
      SNIPPET
    end

    def text_field_with_hint
      <<~SNIPPET
        f.govuk_text_field :name,
          hint_text: 'You can find it on your birth certificate'
      SNIPPET
    end

    def text_field_with_attributes
      <<~SNIPPET
        f.govuk_text_field :name,
          placeholder: "Milhouse van Houten",
          autocomplete: "name"
      SNIPPET
    end

    def text_field_with_custom_width
      <<~SNIPPET
        f.govuk_text_field :name, width: 2
      SNIPPET
    end
  end
end
