module GOVUKDesignSystemFormBuilder
  module Traits
    module Caption
    private

      def caption_element
        @caption_element ||= if @caption.nil?
                               Elements::Null.new
                             else
                               Elements::Caption.new(*bound, **@caption)
                             end
      end
    end
  end
end
