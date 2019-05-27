module GOVUKDesignSystemFormBuilder
  module Labels
  private
    def govuk_label(attribute_name, text, label_weight:, label_size:)
      tag.label(
        text || attribute_name.capitalize,
        class: %w(govuk-label)
          .push(label_size(label_size))
          .push(label_weight(label_weight))
          .compact,
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

    def label_size(size)
      case size
      when 'large'   then "govuk-!-font-size-48"
      when 'medium'  then "govuk-!-font-size-36"
      when 'small'   then "govuk-!-font-size-27"
      when 'regular' then nil
      else
        fail 'size must be either large, medium, small or regular'
      end
    end

    def label_weight(weight)
      case weight
      when 'bold'    then "govuk-!-font-weight-bold"
      when 'regular' then nil
      else
        fail 'weight must be bold or regular'
      end
    end
  end
end
