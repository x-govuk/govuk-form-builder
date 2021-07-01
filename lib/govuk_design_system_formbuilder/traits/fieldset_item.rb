module GOVUKDesignSystemFormBuilder
  module Traits
    module FieldsetItem
      using PrefixableArray

      def html
        safe_join([item, @conditional_content])
      end

    private

      def class_prefix
        %(#{brand}-#{input_type})
      end

      def item
        tag.div(class: %(#{class_prefix}__item)) do
          safe_join([input, label_element, hint_element])
        end
      end

      def options
        {
          id: field_id(link_errors: @link_errors),
          class: classes,
          multiple: @multiple,
          aria: { describedby: [hint_id] },
          data: { 'aria-controls' => @conditional_id }
        }
      end

      def classes
        [%(#{class_prefix}__input)]
      end

      def label_element
        @label_element ||= if @label.nil?
                             Elements::Null.new
                           else
                             Elements::Label.new(*bound, **label_content, **label_options)
                           end
      end

      def label_options
        { value: @value, link_errors: @link_errors }.merge(fieldset_options)
      end

      def hint_element
        @hint_element ||= if @hint.nil?
                            Elements::Null.new
                          else
                            Elements::Hint.new(*bound, **hint_options, **hint_content)
                          end
      end

      def hint_options
        { value: @value }.merge(fieldset_options)
      end

      def conditional_id
        build_id('conditional')
      end

      def conditional_content(block_content)
        if block_content.present?
          @conditional_content = conditional_container(block_content)
          @conditional_id = conditional_id
        end
      end

      def conditional_container(content)
        tag.div(class: conditional_classes, id: conditional_id) do
          content
        end
      end

      def conditional_classes
        %w(__conditional __conditional--hidden).prefix(class_prefix, delimiter: nil)
      end
    end
  end
end
