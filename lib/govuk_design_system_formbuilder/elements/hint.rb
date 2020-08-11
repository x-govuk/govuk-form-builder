module GOVUKDesignSystemFormBuilder
  module Elements
    class Hint < Base
      using PrefixableArray

      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, value: nil, text: nil, radio: false, checkbox: false)
        super(builder, object_name, attribute_name)

        @value    = value
        @text     = retrieve_text(text)
        @radio    = radio
        @checkbox = checkbox
      end

      def active?
        @text.present?
      end

      def html
        return nil unless active?

        tag.span(@text, class: classes, id: hint_id)
      end

      def hint_id
        return nil unless active?

        build_id('hint')
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
