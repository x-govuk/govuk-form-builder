module Examples
  module ErrorHandling
    def text_field_with_errors
      object.valid?

      <<~SNIPPET
        = f.govuk_text_field :favourite_shade_of_red,
          label: { text: 'What is your favourite shade of red?', tag: 'h3', size: 'm' }
      SNIPPET
    end
  end
end
