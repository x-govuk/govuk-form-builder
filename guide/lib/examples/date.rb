module Examples
  module Date
    def date_field
      <<~SNIPPET
        = f.govuk_date_field :date_of_birth,
          legend: { text: 'Enter your date of birth' },
          hint_text: 'It says it on your passport'
      SNIPPET
    end
  end
end
