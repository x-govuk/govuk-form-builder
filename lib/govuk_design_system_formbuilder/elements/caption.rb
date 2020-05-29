module GOVUKDesignSystemFormBuilder
  module Elements
    class Caption < Base
      def initialize(builder:, text:, size: 'm')
        @builder = builder
        @text    = text
        @size    = caption_size_class(size)
      end

      def html
        return nil if @text.blank?

        tag.span(@text, class: @size)
      end

      def caption_size_class(size)
        case size
        when 'xl'      then %(#{brand}-caption-xl)
        when 'l'       then %(#{brand}-caption-l)
        when 'm'       then %(#{brand}-caption-m)
        else
          fail ArgumentError, "invalid size '#{size}', must be xl, l or m"
        end
      end
    end
  end
end
