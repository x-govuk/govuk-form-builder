module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < Base
      include Traits::Error
      include Traits::Label
      include Traits::Hint
      include Traits::Supplemental

      def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, options: {}, html_options: {}, hint_text:, label:, caption:, &block)
        super(builder, object_name, attribute_name, &block)

        @collection    = collection
        @value_method  = value_method
        @text_method   = text_method
        @options       = options
        @html_options  = html_options
        @label         = label
        @caption       = caption
        @hint_text     = hint_text
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, select])
        end
      end

    private

      def select
        @builder.collection_select(@attribute_name, @collection, @value_method, @text_method, @options, **options)
      end

      def options
        @html_options.deep_merge(
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: described_by(hint_id, error_id, supplemental_id) }
        )
      end

      def classes
        [%(#{brand}-select), error_class, custom_classes].flatten.compact
      end

      def error_class
        %(#{brand}-select--error) if has_errors?
      end

      def custom_classes
        @html_options.dig(:class)
      end
    end
  end
end
