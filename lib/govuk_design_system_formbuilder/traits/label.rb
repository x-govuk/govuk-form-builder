module GOVUKDesignSystemFormBuilder
  module Traits
    module Label
    private

      def label_element
        @label_element ||= if @label.nil?
                             Elements::Null.new
                           else
                             Elements::Label.new(*bound, caption: @caption, **label_content)
                           end
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
