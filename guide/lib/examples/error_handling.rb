module Examples
  module ErrorHandling
    def text_field_with_errors
      object.valid?
      <<~SNIPPET
        = f.govuk_text_field :reference_number,
          label: { text: 'What is your reference number?' }
      SNIPPET
    end
  end
end
