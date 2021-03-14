module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < Base
      include Traits::Error
      include Traits::Label
      include Traits::Hint
      include Traits::Supplemental
      include Traits::HTMLAttributes

      def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, hint:, label:, caption:, form_group:, options: {}, **kwargs, &block)
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

        # FIXME remove this soon, worth informing people who miss the release notes that the
        #       args have changed though.
        if :html_options.in?(kwargs.keys)
          Rails.logger.warn("GOVUKDesignSystemFormBuilder: html_options has been deprecated, use keyword arguments instead")
        end
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, select])
        end
      end

    private

      def select
        @builder.collection_select(@attribute_name, @collection, @value_method, @text_method, @options, **attributes(@html_attributes))
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: described_by(hint_id, error_id, supplemental_id) }
        }
      end

      def classes
        [%(#{brand}-select), error_class].flatten.compact
      end

      def error_class
        %(#{brand}-select--error) if has_errors?
      end
    end
  end
end
