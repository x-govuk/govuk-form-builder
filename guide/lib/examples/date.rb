module Examples
  module Date
    def date_field
      <<~SNIPPET
        = f.govuk_date_field :date_of_birth,
          date_of_birth: true,
          legend: { text: 'Enter your date of birth' },
          hint: { text: 'For example, 31 3 1980' }
      SNIPPET
    end

    def month_field
      <<~SNIPPET
        = f.govuk_date_field :graduation_month,
          omit_day: true,
          legend: { text: 'When did you graduate?' },
          hint: { text: 'For example, 3 2014' }
      SNIPPET
    end

    def maxlength_enabled_field
      <<~SNIPPET
        = f.govuk_date_field :date_of_trade,
          maxlength_enabled: true,
          legend: { text: 'When are you planning to trade the goods?' },
          hint: { text: 'Use the format day, month, year, for example 27 3 2021' }
      SNIPPET
    end
  end
end
