module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Label < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, object_name, attribute_name, checkbox, value:, link_errors: true)
          super(builder, object_name, attribute_name)

          @checkbox    = checkbox
          @value       = value
          @link_errors = link_errors
        end

        def html
          @checkbox.label(for: field_id(link_errors: @link_errors), class: label_classes)
        end

      private

        def label_classes
          %w(govuk-label govuk-checkboxes__label)
        end
      end
    end
  end
end
