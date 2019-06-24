module GOVUKDesignSystemFormBuilder
  module Elements
    class Hint < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, options = {})
        super(builder, object_name, attribute_name)
        @text = options&.dig(:text)
        @extra_classes = options&.dig(:class)
        @hint_id = options&.dig(:id)
      end

      def html
        return nil unless @text.present?

        @builder.tag.span(@text, class: hint_classes, id: hint_id)
      end

    private

      def hint_classes
        %w(govuk-hint).push(@extra_classes).compact
      end
    end
  end
end
