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
  end
end
