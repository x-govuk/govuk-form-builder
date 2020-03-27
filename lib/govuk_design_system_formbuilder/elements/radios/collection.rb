module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class Collection < Base
        include Traits::Error
        include Traits::Hint
        include Traits::Supplemental

        def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, hint_method:, hint_text:, legend:, inline:, small:, bold_labels:, classes:, &block)
          super(builder, object_name, attribute_name, &block)

          @collection    = collection
          @value_method  = value_method
          @text_method   = text_method
          @hint_method   = hint_method
          @inline        = inline
          @small         = small
          @legend        = legend
          @hint_text     = hint_text
          @classes       = classes
          @bold_labels   = hint_method.present? || bold_labels
        end

        def html
          Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
            Containers::Fieldset.new(@builder, @object_name, @attribute_name, legend: @legend, described_by: [error_id, hint_id, supplemental_id]).html do
              safe_join(
                [
                  hint_element.html,
                  supplemental_content.html,
                  error_element.html,
                  Containers::Radios.new(@builder, inline: @inline, small: @small, classes: @classes).html do
                    safe_join(build_collection)
                  end
                ]
              )
            end
          end
        end

      private

        def build_collection
          @collection.map.with_index do |item, i|
            Elements::Radios::CollectionRadioButton.new(
              @builder,
              @object_name,
              @attribute_name,
              item,
              value_method: @value_method,
              text_method: @text_method,
              hint_method: @hint_method,
              link_errors: has_errors? && i.zero?,
              bold_labels: @bold_labels
            ).html
          end
        end
      end
    end
  end
end
