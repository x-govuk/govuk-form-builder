module GOVUKDesignSystemFormBuilder
  module Elements
    class TextArea < Base
      def initialize(builder, object_name, attribute_name, hint:, label:, rows:, max_words:, max_chars:, **extra_args)
        super(builder, object_name, attribute_name)
        @label      = label
        @hint       = hint
        @extra_args = extra_args
      end

      def html
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint)
        label_element = Elements::Label.new(@builder, @object_name, @attribute_name, @label)
        error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          @builder.safe_join(
            [
              label_element.html,
              hint_element.html,
              error_element.html,
              @builder.text_area(@attribute_name, **@extra_args)
            ]
          )
        end
      end
    end
  end
end
