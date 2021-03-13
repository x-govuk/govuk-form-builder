module GOVUKDesignSystemFormBuilder
  module Traits
    module Hint
      def hint_id
        return unless hint_element.active?

        build_id('hint')
      end

    private

      def hint_element
        @hint_element ||= if @hint.nil?
                            Elements::Null.new
                          else
                            Elements::Hint.new(@builder, @object_name, @attribute_name, **hint_content)
                          end
      end

      def hint_content
        case @hint
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
