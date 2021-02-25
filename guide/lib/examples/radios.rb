module Examples
  module Radios
    def radio_field_with_legend_and_hint
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :new_department_id,
          departments,
          :id,
          :name,
          legend: { text: 'Which department do you work for?' },
          hint: { text: 'There should be a sign near your desk' }
      SNIPPET
    end

    def radio_field_with_label_and_descriptions
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :lunch_id,
          lunch_options,
          :id,
          :name,
          :description,
          legend: { text: 'What would you like for lunch?' }
      SNIPPET
    end

    def small_radio_field
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :wednesday_lunch_id,
          lunch_options,
          :id,
          :name,
          :description,
          small: true,
          legend: { text: 'What would you like for lunch on Wednesday?' }
      SNIPPET
    end

    def inline_radio_field
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :thursday_lunch_id,
          lunch_options,
          :id,
          :name,
          inline: true,
          legend: { text: 'What would you like for lunch on Thursday?' }
      SNIPPET
    end

    def radio_field_with_conditional_content
      <<~SNIPPET
        = f.govuk_radio_buttons_fieldset(:old_department_id, legend: { size: 'm', text: 'Which department do you work in?' }) do
          = f.govuk_radio_button :old_department_id, 'it', label: { text: 'Information Technology' }, link_errors: true
          = f.govuk_radio_button :old_department_id, 'marketing', label: { text: 'Marketing' }, hint: { text: 'Includes Sales and Digital Marketing' }
          = f.govuk_radio_divider
          = f.govuk_radio_button :old_department_id, 'other', label: { text: 'Other' } do
            = f.govuk_text_field :old_department_description,
              label: { text: 'Which department did you work in most recently?' }
      SNIPPET
    end

    def radio_field_with_proc_labels_and_hints_locale
      <<~LOCALE
        laptops:
          names:
            thinkpad: Lenovo ThinkPad X1 Carbon
            macbook_pro: MacBook Pro
            xps: Dell XPS
            zenbook: Asus ZenBook
          descriptions:
            macbook_pro: |-
              The MacBook Pro is a line of Macintosh portable computers
              introduced in January 2006, by Apple Inc.
            thinkpad: |-
              ThinkPad, known for their minimalist, black and boxy design, is a
              line of business-oriented laptops designed, developed, marketed,
              and sold by Lenovo (formerly IBM)
            zenbook: |-
              Zenbook are a family of ultrabooks – low-bulk laptop computers –
              produced by Asus.
            xps: |-
              Dell XPS 'Xtreme Performance System' is a line of high
              performance computers manufactured by Dell.
      LOCALE
    end

    def radio_field_with_proc_labels_and_hints
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :laptop,
          laptops,
          ->(option) { option },
          ->(option) { I18n.t('laptops.names.' + option) },
          ->(option) { I18n.t('laptops.descriptions.' + option) },
          legend: { text: "Which laptop would you like to use?" }
      SNIPPET
    end
  end
end
