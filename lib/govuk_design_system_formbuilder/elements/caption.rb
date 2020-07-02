module GOVUKDesignSystemFormBuilder
  module Elements
    class Caption < Base
      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, text:, size: nil)
        super(builder, object_name, attribute_name)

        @text       = caption_text(text)
        @size_class = caption_size_class(size)
      end

      def html
        return nil if @text.blank?

        tag.span(@text, class: @size_class)
      end

    private

      def caption_text(override)
        override || localised_text(:caption)
      end

      def caption_size_class(size)
        case size || config.default_caption_size
        when 'xl' then %(#{brand}-caption-xl)
        when 'l'  then %(#{brand}-caption-l)
        when 'm'  then %(#{brand}-caption-m)
        else
          fail ArgumentError, "invalid size '#{size}', must be xl, l or m"
        end
      end
    end
  end
end
