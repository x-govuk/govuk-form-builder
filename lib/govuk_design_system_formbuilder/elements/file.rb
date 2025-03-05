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

      def initialize(builder, object_name, attribute_name, hint:, label:, caption:, form_group:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label           = label
        @caption         = caption
        @hint            = hint
        @html_attributes = kwargs
        @form_group      = form_group
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, file])
        end
      end

    private

      def file
        tag.div(@builder.file_field(@attribute_name, attributes(@html_attributes)), **drop_zone_options)
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

      def drop_zone_options
        { class: "#{brand}-drop-zone", data: { module: "#{brand}-file-upload" } }
      end
    end
  end
end
