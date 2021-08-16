module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Label < Base
        using PrefixableArray

        include Traits::Localisation

        def initialize(builder, object_name, attribute_name, checkbox, value:, link_errors: true)
          super(builder, object_name, attribute_name)

          @checkbox    = checkbox
          @value       = value
          @link_errors = link_errors
        end

        def html
          @checkbox.label(for: field_id(link_errors: @link_errors), class: label_classes) do
            label_content.to_s
          end
        end

      private

        def label_classes
          %w(label checkboxes__label).prefix(brand)
        end

        def label_content
          [localised_text(:label), @checkbox.text, @value].find(&:presence)
        end
      end
    end
  end
end
