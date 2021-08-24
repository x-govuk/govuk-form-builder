module Examples
  module ErrorHandling
    def form_with_multiple_errors
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

    def form_with_errors_on_object_base
      <<~SNIPPET
        = f.govuk_error_summary link_base_errors_to: :email_address

        = f.govuk_email_field :email_address, label: { text: "Email address" }
        = f.govuk_phone_field :telephone_number, label: { text: "Phone number" }
      SNIPPET
    end

    def form_with_presenter_injection
      <<~SNIPPET
        ruby:
          # In controller typically
          @error_presenter = ErrorPresenter.new

        = f.govuk_error_summary(presenter: @error_presenter)

        = f.govuk_text_field :name,
          label: { text: 'Name' },
          hint: { text: 'You can find it on your birth certificate' }

        = f.govuk_date_field :date_of_birth,
          date_of_birth: true,
          legend: { text: 'Enter your date of birth' },
          hint: { text: 'For example, 31 3 1980' }
      SNIPPET
    end
  end
end
