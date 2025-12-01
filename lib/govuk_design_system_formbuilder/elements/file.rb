module GOVUKDesignSystemFormBuilder
  module Elements
    class File < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental
      include Traits::HTMLAttributes
      include Traits::HTMLClasses
      include Traits::ContentBeforeAndAfter

      def initialize(builder, object_name, attribute_name, hint:, label:, caption:, form_group:, javascript:, before_input:, after_input:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label           = label
        @caption         = caption
        @hint            = hint
        @html_attributes = kwargs
        @form_group      = form_group
        @javascript      = javascript
        @before_input    = before_input
        @after_input     = after_input
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, before_input_content, file_html, after_input_content])
        end
      end

    private

      def file_html
        @javascript ? file_with_javascript_markup : file
      end

      def file
        @builder.file_field(@attribute_name, attributes(@html_attributes))
      end

      def file_with_javascript_markup
        tag.div(class: "#{brand}-drop-zone", data: { module: "#{brand}-file-upload" }) { file }
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: combine_references(hint_id, error_id, supplemental_id) }
        }
      end

      def classes
        build_classes(%(file-upload), %(file-upload--error) => has_errors?).prefix(brand)
      end
    end
  end
end
