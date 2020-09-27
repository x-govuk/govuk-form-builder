module GOVUKDesignSystemFormBuilder
  module Traits
    module Hint
      def hint_id
        return nil unless hint_element.active?

        build_id('hint')
      end

    private

      def hint_element
        @hint_element ||= Elements::Hint.new(@builder, @object_name, @attribute_name, **hint_content)
      end

      def hint_content
        case @hint
        when NilClass
          {}
        when Hash
          @hint
        when Proc
          { content: @hint }
        else
          fail(ArgumentError, %(hint must be a Proc or Hash))
        end
      end
    end
  end
end
