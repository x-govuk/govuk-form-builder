module GOVUKDesignSystemFormBuilder
  module Elements
    class File < Base
      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental

      def initialize(builder, object_name, attribute_name, hint_text:, label:, **extra_args, &block)
        super(builder, object_name, attribute_name, &block)

        @label      = label
        @hint_text  = hint_text
        @extra_args = extra_args
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          safe_join(
            [
              label_element.html,
              supplemental_content.html,
              hint_element.html,
              error_element.html,
              @builder.file_field(
                @attribute_name,
                id: field_id(link_errors: true),
                class: file_classes,
                aria: { describedby: described_by(hint_id, error_id, supplemental_id) },
                **@extra_args
              )
            ]
          )
        end
      end

    private

      def file_classes
        %w(govuk-file-upload).tap do |c|
          c.push('govuk-file-upload--error') if has_errors?
        end
      end
    end
  end
end
