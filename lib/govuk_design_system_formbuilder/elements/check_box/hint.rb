module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBox
      class Hint
        def initialize(builder, text)
          @builder = builder
          @text    = text
        end

        def html
          @builder.tag.span(@text, class: hint_classes)
        end

        private

        def hint_classes
          %w(govuk-hint govuk-checkboxes__hint)
        end
      end
    end
  end
end
