module GOVUKDesignSystemFormBuilder
  module Elements
    class File < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental

      def initialize(builder, object_name, attribute_name, hint_text:, label:, caption:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label         = label
        @caption       = caption
        @hint_text     = hint_text
        @extra_options = kwargs
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, file])
        end
      end

    private

      def file
        @builder.file_field(@attribute_name, **options, **@extra_options)
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: described_by(hint_id, error_id, supplemental_id) }
        }
      end

      def classes
        %w(file-upload).prefix(brand).tap do |c|
          c.push(%(#{brand}-file-upload--error)) if has_errors?
        end
      end
    end
  end
end
