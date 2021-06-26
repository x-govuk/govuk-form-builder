module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < Base
      include Traits::Error
      include Traits::Label
      include Traits::Hint
      include Traits::HTMLAttributes
      include Traits::Select

      def initialize(builder, object_name, attribute_name, choices, options:, form_group:, label:, hint:, caption:, **kwargs, &block)
        # assign the block to an variable rather than passing to super so
        # we can send it through to #select
        super(builder, object_name, attribute_name)
        @block           = block

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
        @builder.select(@attribute_name, @choices, @options, attributes(@html_attributes), &@block)
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: combine_references(hint_id, error_id) }
        }
      end
    end
  end
end
