module Examples
  module LabelsCaptionsHintsAndLegends
    def text_field_with_no_label
      "= f.govuk_text_field :favourite_colour"
    end

    def text_field_with_configured_label
      <<~SNIPPET
        = f.govuk_text_field :favourite_shade_of_red,
          label: { text: 'What is your favourite shade of red?', tag: 'h3', size: 'm' }
      SNIPPET
    end

    def text_field_with_label_proc
      <<~SNIPPET
        = f.govuk_text_field :favourite_shade_of_orange,
          label: -> do
            h2.orange-underline.govuk-header-m
              | What's your favourite shade of orange?
      SNIPPET
    end

    def text_field_with_caption
      <<~SNIPPET
        = f.govuk_text_field :favourite_shade_of_grey,
          label: { text: 'Favourite shade of grey', tag: 'h2', size: 'l' },
          caption: { text: 'Aesthetic preferences', size: 'm' }
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
        = f.govuk_collection_radio_buttons :favourite_colour,
          primary_colours,
          :id,
          :name,
          legend: { text: "What's your favourite primary colour?", size: 'l', tag: 'h4' }
      SNIPPET
    end

    def radios_with_legend_proc
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :least_favourite_colour,
          primary_colours,
          :id,
          :name,
          legend: -> do
            h3.govuk-heading-l
              ' Which

              span.ugly-gradient colour

              ' do you hate most?
      SNIPPET
    end
  end
end
