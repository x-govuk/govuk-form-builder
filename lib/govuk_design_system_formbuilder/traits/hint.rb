module GOVUKDesignSystemFormBuilder
  module Traits
    module Hint
      def hint_id
        return nil if @hint_text.blank?

        build_id('hint')
      end

    private

      def hint_element
        @hint_element ||= Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text)
      end
    end
  end
end
