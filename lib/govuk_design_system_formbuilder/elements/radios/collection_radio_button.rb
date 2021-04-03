module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class CollectionRadioButton < Base
        include Traits::Hint
        include Traits::CollectionItem

        # @param link_errors [Boolean] used to control the id generated for radio buttons. The
        #   error summary requires that the id of the first radio is linked-to from the corresponding
        #   error message. As when the summary is built what happens later in the form is unknown, we
        #   need to control this to ensure the link is generated correctly
        def initialize(builder, object_name, attribute_name, item, value_method:, text_method:, hint_method:, bold_labels:, link_errors: false)
          super(builder, object_name, attribute_name)

          @item        = item
          @value       = retrieve(item, value_method)
          @label_text  = retrieve(item, text_method)
          @hint_text   = retrieve(item, hint_method)
          @link_errors = link_errors
          @bold_labels = bold_labels
        end

        def html
          tag.div(class: %(#{brand}-radios__item)) do
            safe_join([radio, label_element, hint_element])
          end
        end

      private

        def radio
          @builder.radio_button(@attribute_name, @value, **options)
        end

        def options
          {
            id: field_id(link_errors: @link_errors),
            aria: { describedby: [hint_id] },
            class: %(#{brand}-radios__input)
          }
        end

        def hint_element
          @hint_element ||= Elements::Hint.new(*bound, **hint_options, **hint_content)
        end

        def hint_content
          { text: @hint_text }
        end

        def hint_options
          { value: @value, radio: true }
        end

        def label_element
          @label_element ||= Elements::Label.new(*bound, **label_options)
        end

        def label_options
          {
            text: @label_text,
            value: @value,
            radio: true,
            size: label_size,
            link_errors: @link_errors
          }
        end

        def label_size
          @bold_labels.present? ? 's' : nil
        end
      end
    end
  end
end
