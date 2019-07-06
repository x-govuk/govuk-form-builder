module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Label
        def initialize(builder)
          @builder = builder
        end

        def html
          @builder.label(class: label_classes)
        end

      private

        def label_classes
          %w(govuk-label govuk-checkboxes__label)
        end
      end
    end
  end
end
