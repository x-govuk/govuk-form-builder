module GOVUKDesignSystemFormBuilder
  module Elements
    class Hint < Base
      using PrefixableArray

      include Traits::Hint
      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, text, value = nil, radio: false, checkbox: false)
        super(builder, object_name, attribute_name)

        @value     = value
        @hint_text = retrieve_text(text)
        @radio     = radio
        @checkbox  = checkbox
      end

      def html
        return nil if @hint_text.blank?

        tag.span(@hint_text, class: classes, id: hint_id)
      end

    private

      def retrieve_text(supplied)
        supplied.presence || localised_text(:hint)
      end

      def classes
        %w(hint).prefix(brand).push(radio_class, checkbox_class).compact
      end

      def radio_class
        @radio ? %(#{brand}-radios__hint) : nil
      end

      def checkbox_class
        @checkbox ? %(#{brand}-checkboxes__hint) : nil
      end
    end
  end
end
