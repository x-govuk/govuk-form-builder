module Examples
  module LabelsHintsAndLegends
    def text_field_with_no_label
      "= f.govuk_text_field :favourite_colour"
    end

    def text_field_with_configured_label
      <<~SNIPPET
        = f.govuk_text_field :favourite_shade_of_red,
          label: { text: 'What is your favourite shade of red?', tag: 'h3', size: 'm' }
      SNIPPET
    end

    def text_field_with_hint
      <<~SNIPPET
        = f.govuk_text_field :favourite_shade_of_blue,
          label: { text: 'What is your favourite shade of blue?' },
          hint_text: 'The shade you reach for first when painting the sky'
      SNIPPET
    end

    def radios_with_legend
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :new_department_id,
          primary_colours,
          :id,
          :name,
          legend: { text: "What's your favourite primary colour?", size: 'l', tag: 'h4' }
      SNIPPET
    end
  end
end
