module Examples
  module Select
    def select_field_with_label_and_hint
      <<~SNIPPET
        = f.govuk_collection_select :new_department_id,
          departments,
          :id,
          :name,
          label: { text: "Which department do you work in?" },
          hint: { text: "You can find it on your ID badge" }
      SNIPPET
    end

    def select_field_with_grouped_options
      <<~SNIPPET
        = f.govuk_select(:lunch_id, label: { text: "Preferred lunch", size: "m" }) do
          - grouped_lunch_options.each do |group_name, menu_items|
            optgroup label=group_name
              - menu_items.each do |name, value|
                option value=value data-tags=name.downcase
                  = name
      SNIPPET
    end
  end
end
