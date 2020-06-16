module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class Collection < Base
        include Traits::Error
        include Traits::Hint
        include Traits::Supplemental

        def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, hint_method:, hint_text:, legend:, caption:, inline:, small:, bold_labels:, classes:, &block)
          super(builder, object_name, attribute_name, &block)

          @collection    = collection
          @value_method  = value_method
          @text_method   = text_method
          @hint_method   = hint_method
          @inline        = inline
          @small         = small
          @legend        = legend
          @caption       = caption
          @hint_text     = hint_text
          @classes       = classes
          @bold_labels   = hint_method.present? || bold_labels
        end

        def html
          Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
            Containers::Fieldset.new(@builder, @object_name, @attribute_name, legend: @legend, caption: @caption, described_by: [error_id, hint_id, supplemental_id]).html do
              safe_join([supplemental_content, hint_element, error_element, radios])
            end
          end
        end

      private

        def radios
          Containers::Radios.new(@builder, inline: @inline, small: @small, classes: @classes).html do
            safe_join(collection)
          end
        end

        def collection
          @collection.map.with_index do |item, i|
            Elements::Radios::CollectionRadioButton.new(@builder, @object_name, @attribute_name, item, **collection_options(i)).html
          end
        end

        def collection_options(index)
          {
            value_method: @value_method,
            text_method: @text_method,
            hint_method: @hint_method,
            link_errors: link_errors?(index),
            bold_labels: @bold_labels
          }
        end

        def link_errors?(index)
          has_errors? && index.zero?
        end
      end
    end
  end
end
