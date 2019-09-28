module Examples
  module ErrorHandling
    def text_field_with_errors
      object.valid?

      <<~SNIPPET
        = f.govuk_error_summary

        h2.govuk-heading-l
          | Register your interest in becoming a teacher

        = f.govuk_text_field :welcome_pack_reference_number,
          width: 10,
          label: { text: 'What is your reference number?', size: 's' }

        = f.govuk_date_field :welcome_pack_received_on,
          legend: { text: 'When did you receive your welcome pack?', size: 's' }

        = f.govuk_collection_select :department_id,
          departments,
          :id,
          :name,
          label: { text: 'Which department will you work in?', size: 's' }

        = f.govuk_collection_radio_buttons :welcome_lunch_choice,
          lunch_options,
          :id,
          :name,
          :description,
          legend: { text: 'What would you like for lunch on your first day?', size: 's' }
      SNIPPET
    end
  end
end
