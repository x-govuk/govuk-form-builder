module GOVUKDesignSystemFormBuilder
  module Elements
    class CollectionSelect < Base
      include Traits::Error
      include Traits::Label
      include Traits::Hint
      include Traits::Supplemental
      include Traits::HTMLAttributes
      include Traits::Select
      include Traits::ContentBeforeAndAfter

      def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, hint:, label:, caption:, form_group:, before_input:, after_input:, options: {}, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @collection      = collection
        @value_method    = value_method
        @text_method     = text_method
        @options         = options
        @label           = label
        @caption         = caption
        @hint            = hint
        @form_group      = form_group
        @html_attributes = kwargs
        @before_input    = before_input
        @after_input     = after_input

        # FIXME remove this soon, worth informing people who miss the release notes that the
        #       args have changed though.
        if :html_options.in?(kwargs.keys)
          warn("GOVUKDesignSystemFormBuilder: html_options has been deprecated, use keyword arguments instead")
        end
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, before_input_content, collection_select, after_input_content])
        end
      end

    private

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: combine_references(hint_id, error_id, supplemental_id) }
        }
      end

      def collection_select
        @builder.collection_select(@attribute_name, @collection, @value_method, @text_method, @options, **attributes(@html_attributes))
      end
    end
  end
end
