module Examples
  module Select
    def departments_data
      <<~DATA
        @departments = [
          OpenStruct.new(id: 1, name: 'Sales'),
          OpenStruct.new(id: 2, name: 'Marketing'),
          OpenStruct.new(id: 3, name: 'Finance')
        ]
      DATA
    end

    def select_field
      <<~SNIPPET
        = f.govuk_collection_select :department_id,
          departments,
          :id,
          :name
      SNIPPET
    end

    def select_field_with_label
      <<~SNIPPET
        = f.govuk_collection_select :old_department_id,
          departments,
          :id,
          :name,
          label: { text: "Which department do you work in?" }
      SNIPPET
    end

    def select_field_with_hint_text
      <<~SNIPPET
        = f.govuk_collection_select :new_department_id,
          departments,
          :id,
          :name,
          hint_text: "You can find it on your ID badge"
      SNIPPET
    end
  end
end
