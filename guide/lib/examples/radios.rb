module Examples
  module Radios
    def radio_field_with_legend_and_hint
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :new_department_id,
          departments,
          :id,
          :name,
          legend: { text: 'Which department do you work for?' },
          hint_text: 'There should be a sign near your desk'
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

    def radio_field_with_conditional_content
      <<~SNIPPET
        = f.govuk_radio_buttons_fieldset(:old_department_id, legend: { size: 'm', text: 'Which department do you work in?' }) do
          = f.govuk_radio_button :old_department_id, 'it', label: { text: 'Information Technology' }
          = f.govuk_radio_button :old_department_id, 'marketing', label: { text: 'Marketing' }
          = f.govuk_radio_divider
          = f.govuk_radio_button :old_department_id, 'other', label: { text: 'Other' } do
            = f.govuk_text_field :old_department_description,
              label: { text: 'Which department did you work in most recently?' }
      SNIPPET
    end
  end
end
