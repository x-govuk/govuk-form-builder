module Examples
  module SubmitButton
    def submit_button
      "= f.govuk_submit"
    end

    def secondary_button
      "= f.govuk_submit 'Find address', secondary: true"
    end

    def warning_button
      "= f.govuk_submit 'Delete all records', warning: true"
    end

    def submit_button_without_double_click_prevention
      "= f.govuk_submit prevent_double_click: false"
    end

    def multiple_buttons
      <<~SNIPPET
        = f.govuk_submit 'Save and continue' do
          a.govuk-button.govuk-button--secondary href='/documents'
            ' Safe as draft
      SNIPPET
    end
  end
end
