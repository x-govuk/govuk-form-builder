module GOVUKDesignSystemFormBuilder
  module Traits
    module Label
    private

      def label_element
        @label_element ||= Elements::Label.new(@builder, @object_name, @attribute_name, caption: @caption, **label_content)
      end

      def label_content
        case @label
        when Hash
          @label
        when Proc
          { content: @label }
        else
          fail(ArgumentError, %(label must be a Proc or Hash))
        end
      end
    end
  end
end
