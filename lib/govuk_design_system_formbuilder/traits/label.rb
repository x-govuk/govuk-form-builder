module GOVUKDesignSystemFormBuilder
  module Traits
    module Label
    private

      def label_element
        @label_element ||= Elements::Label.new(@builder, @object_name, @attribute_name, **@label)
      end
    end
  end
end
