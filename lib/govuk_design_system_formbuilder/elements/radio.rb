module GOVUKDesignSystemFormBuilder
  module Elements
    class Radio < GOVUKDesignSystemFormBuilder::Base
      def hint_id
        return nil unless @hint.present?

        [@object_name, @attribute_name, @value, 'hint'].join('-').parameterize
      end

      def radio_hint_classes
        %w(govuk-hint govuk-radios__hint)
      end
    end
  end
end
