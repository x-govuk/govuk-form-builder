module GOVUKDesignSystemFormBuilder
  module Labels
    def govuk_label(attribute_name, label_options)
      tag.label(
        label_options.dig(:text) || attribute_name.capitalize,
        class: %w(govuk-label)
          .push(label_size(label_options.dig(:size)))
          .push(label_weight(label_options.dig(:weight)))
          .compact,
        for: attribute_identifier(attribute_name)
      )
    end

    def govuk_hint(attribute_name, hint_options)
      tag.span(
        hint_options.dig(:text),
        class: 'govuk-hint',
        id: hint_id(attribute_name)
      )
    end

  private

    def govuk_label_defaults
      { weight: 'regular', size: 'regular' }
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

    def govuk_hint_defaults
      {}
    end
  end
end
