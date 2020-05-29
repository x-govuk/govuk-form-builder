module GOVUKDesignSystemFormBuilder
  module Traits
    module Caption
    private

      def caption_element
        @caption_element ||= Elements::Caption.new(
          **{ text: nil }.merge(
            {
              builder: @builder,
              text: caption_text,
              size: caption_size
            }.compact
          )
        )
      end

      def caption_text
        return nil if @caption.blank?

        @caption.dig(:text)
      end

      def caption_size
        return nil if @caption.blank?

        @caption.dig(:size)
      end
    end
  end
end
