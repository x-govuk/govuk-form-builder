module GOVUKDesignSystemFormBuilder
  module Elements
    class File < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, hint_text:, label:, **extra_args)
        super(builder, object_name, attribute_name)

        @label      = label
        @hint_text  = hint_text
        @extra_args = extra_args
      end

      def html
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text)
        label_element = Elements::Label.new(@builder, @object_name, @attribute_name, @label)
        error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          @builder.safe_join(
            [
              label_element.html,
              hint_element.html,
              error_element.html,
              @builder.file_field(
                @attribute_name,
                id: field_id(link_errors: true),
                class: file_classes,
                aria: {
                  describedby: [
                    hint_element.hint_id,
                    error_element.error_id
                  ].compact.join(' ').presence
                },
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
