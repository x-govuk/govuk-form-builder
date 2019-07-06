module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Hint
        def initialize(builder, attribute, checkbox, text)
          @builder   = builder
          @attribute = attribute
          @checkbox  = checkbox
          @text      = text
        end

        def html
          return nil if @text.blank?

          @builder.tag.span(@text, class: hint_classes, id: id)
        end

        def id
          return nil if @text.blank?

          [
            @attribute,
            @checkbox.object.id,
            'hint'
          ]
            .join('-')
            .parameterize
        end

      private

        def hint_classes
          %w(govuk-hint govuk-checkboxes__hint)
        end
      end
    end
  end
end
