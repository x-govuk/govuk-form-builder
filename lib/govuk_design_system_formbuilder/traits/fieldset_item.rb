module GOVUKDesignSystemFormBuilder
  module Traits
    module FieldsetItem
    private

      def label_element
        @label_element ||= if @label.nil?
                             Elements::Null.new
                           else
                             Elements::Label.new(@builder, @object_name, @attribute_name, **label_content, **label_options)
                           end
      end

      def label_options
        { value: @value, link_errors: @link_errors }.merge(fieldset_options)
      end

      def hint_element
        @hint_element ||= Elements::Hint.new(@builder, @object_name, @attribute_name, **hint_options, **hint_content)
      end

      def hint_options
        { value: @value }.merge(fieldset_options)
      end
    end
  end
end
