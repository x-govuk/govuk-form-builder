module GOVUKDesignSystemFormBuilder
  module Traits
    module Caption
    private

      def caption_element
        @caption_element ||= Elements::Caption.new(@builder, @object_name, @attribute_name, **caption_options)
      end

      def caption_options
        { text: nil }.merge({ text: caption_text, size: caption_size }.compact)
      end

      def caption_text
        @caption&.dig(:text)
      end

      def caption_size
        @caption&.dig(:size)
      end
    end
  end
end
