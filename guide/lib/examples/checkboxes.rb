module Examples
  module Checkboxes
    def checkbox_field
      <<~SNIPPET
        = f.govuk_collection_check_boxes :department_ids,
          departments,
          :id,
          :name
      SNIPPET
    end

    def checkbox_field_with_hints
      <<~SNIPPET
        = f.govuk_collection_check_boxes :lunch_ids,
          lunch_options,
          :id,
          :name,
          :description
      SNIPPET
    end
  end
end
