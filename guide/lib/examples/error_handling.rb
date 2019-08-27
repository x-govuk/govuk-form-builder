module Examples
  module ErrorHandling
    def text_field_with_errors
      object.valid?
      <<~SNIPPET
        = f.govuk_error_summary

        h2.govuk-heading-m Register your interest in becoming a teacher

        = f.govuk_text_field :reference_number,
          width: 10,
          label: { text: 'What is your reference number?' }
      SNIPPET
    end
  end
end
