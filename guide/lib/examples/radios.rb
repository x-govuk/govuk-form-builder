module Examples
  module Radios
    def departments_data
      <<~DATA
        @departments = [
          OpenStruct.new(id: 1, name: 'Sales'),
          OpenStruct.new(id: 2, name: 'Marketing'),
          OpenStruct.new(id: 3, name: 'Finance')
        ]
      DATA
    end

    def radio_field
      <<~SNIPPET
        = f.govuk_collection_radio_buttons :department_id,
          departments,
          :id,
          :name
      SNIPPET
    end

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
  end
end
