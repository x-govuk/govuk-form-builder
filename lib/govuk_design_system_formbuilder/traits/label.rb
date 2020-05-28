module GOVUKDesignSystemFormBuilder
  module Traits
    module Label
    private

      def label_element
        @label_element ||= Elements::Label.new(@builder, @object_name, @attribute_name, **label_args)
      end

      def label_args
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
