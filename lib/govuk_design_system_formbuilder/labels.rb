module GOVUKDesignSystemFormBuilder
  module Labels
  private
    def govuk_label(attribute_name, text)
      tag.label(
        text,
        class: 'govuk-label',
        for: attribute_identifier(attribute_name)
      )
    end

    def govuk_hint(attribute_name, text)
      tag.span(
        text,
        class: 'govuk-hint',
        id: hint_id(attribute_name)
      )
    end
  end
end
