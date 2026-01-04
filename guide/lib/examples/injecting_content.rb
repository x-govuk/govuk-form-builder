module Examples
  module InjectingContent
    def colleciton_radio_buttons_with_injected_content
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :department_id,
          departments,
          :id,
          :name,
          legend: { text: "Which department do you want to nominate?" } do

            p.final-decision-warning
              | Your decision is final and cannot be edited later
      SNIPPET
    end

    def fields_with_content_injected_before_and_after
      <<~SNIPPET
        = f.govuk_text_field :first_name,
                             label: { text: 'Text field', size: 'l' },
                             before_input: -> { "Some text before" },
                             after_input: -> { %(<span class="govuk-body">Some HTML after</span>) }
      SNIPPET
    end
  end
end
