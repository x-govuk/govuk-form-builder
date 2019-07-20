module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Label < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, object_name, attribute_name, value)
          super(builder, object_name, attribute_name)
          @value = value
        end

        def html
          @builder.label(for: field_id, class: label_classes)
        end

      private

        def label_classes
          %w(govuk-label govuk-checkboxes__label)
        end
      end
    end
  end
end
