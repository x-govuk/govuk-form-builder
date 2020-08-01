module Examples
  module InjectingContent
    def text_area_with_injected_content
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
  end
end
