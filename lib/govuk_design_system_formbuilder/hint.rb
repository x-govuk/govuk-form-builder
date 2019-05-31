module GOVUKDesignSystemFormBuilder
  class Hint
    def initialize(builder, object_name, attribute_name, options = {})
      @builder = builder
      @object_name = object_name
      @attribute_name = attribute_name
      @text = options&.dig(:text)
    end

    def hint_id
      return nil unless @text.present?

      [@object_name, @attribute_name, 'hint'].join('-')
    end

    def html
      return nil unless @text.present?

      @builder.tag.span(@text, class: 'govuk-hint', id: hint_id)
    end
  end
end
