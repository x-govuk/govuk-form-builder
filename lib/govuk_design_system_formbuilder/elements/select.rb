module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, collection, value_method, text_method, options: {}, html_options: {}, hint_text:, label:, &block)
        super(builder, object_name, attribute_name)

        @collection    = collection
        @value_method  = value_method
        @text_method   = text_method
        @options       = options
        @html_options  = html_options
        @label         = label
        @hint_text     = hint_text
        @block_content = @builder.capture { block.call } if block_given?
      end

      def html
        label_element = Elements::Label.new(@builder, @object_name, @attribute_name, @label)
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text)
        error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          @builder.safe_join([
            label_element.html,
            hint_element.html,
            error_element.html,
            @block_content,
            @builder.collection_select(
              @attribute_name,
              @collection,
              @value_method,
              @text_method,
              @options,
              build_html_options(hint_element, error_element)
            )
          ])
        end
      end

    private

      def build_html_options(hint_element, error_element)
        @html_options.deep_merge(
          id: field_id(link_errors: true),
          class: select_classes,
          aria: {
            describedby: [
              hint_element.hint_id,
              error_element.error_id
            ].compact.join(' ').presence
          }
        )
      end

      def select_classes
        %w(govuk-select)
      end
    end
  end
end
