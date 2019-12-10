module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Hint < GOVUKDesignSystemFormBuilder::Base
        include Traits::Hint
        def initialize(builder, object_name, attribute_name, hint_text, value:)
          super(builder, object_name, attribute_name)

          @value     = value
          @hint_text = hint_text
        end

        def html
          return nil if @hint_text.blank?

          tag.span(@hint_text, class: hint_classes, id: id)
        end

        def id
          hint_id
        end

      private

        def hint_classes
          %w(govuk-hint govuk-checkboxes__hint)
        end
      end
    end
  end
end
