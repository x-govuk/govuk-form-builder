module GOVUKDesignSystemFormBuilder
  module Traits
    module Hint
      def hint_id
        return nil unless hint_element.active?

        build_id('hint')
      end

    private

      def hint_element
        @hint_element ||= Elements::Hint.new(@builder, @object_name, @attribute_name, **hint_options)
      end

      def hint_options
        @hint || {}
      end
    end
  end
end
