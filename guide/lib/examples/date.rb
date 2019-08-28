module Examples
  module Date
    def date_field
      <<~SNIPPET
        = f.govuk_date_field :date_of_birth,
          date_of_birth: true,
          legend: { text: 'Enter your date of birth' },
          hint_text: "Check your passport if you're unsure"
      SNIPPET
    end
  end
end
