module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < Base
      include Traits::Error
      include Traits::Label
      include Traits::Hint
      include Traits::HTMLAttributes
      include Traits::Select

      def initialize(builder, object_name, attribute_name, choices, options:, form_group:, label:, hint:, caption:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @form_group      = form_group
        @hint            = hint
        @label           = label
        @caption         = caption
        @choices         = choices
        @options         = options
        @html_attributes = kwargs
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, hint_element, error_element, select])
        end
      end

    private

      def select
        @builder.select(@attribute_name, (@choices || @block_content), @options, **attributes(@html_attributes))
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: described_by(hint_id, error_id) }
        }
      end
    end
  end
end
