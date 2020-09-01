module GOVUKDesignSystemFormBuilder
  module Traits
    module Caption
    private

      def caption_element
        @caption_element ||= Elements::Caption.new(@builder, @object_name, @attribute_name, **caption_options)
      end

      def caption_options
        @caption
      end
    end
  end
end
