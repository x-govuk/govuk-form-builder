module Examples
  module InjectingContent
    def text_area_with_injected_content
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :department_id,
          departments,
          :id,
          :name,
          legend: { text: "Which department do you want to nominate for the 'Best Department' award?" },
          hint_text: "The department will not be notified they've been nominated for an award until the annual awards evening." do

            .govuk-warning-text
              span.govuk-warning-text__icon aria-hidden=true !
              strong.govuk-warning-text__text
                span.govuk-warning-text__assistive
                  | Warning
                | Unlike in previous years, nominations are not
                  anonymous. The list of voters will be published after the
                  prizes have been awarded.
      SNIPPET
    end
  end
end
