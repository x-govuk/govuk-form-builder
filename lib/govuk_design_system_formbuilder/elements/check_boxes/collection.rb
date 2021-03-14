module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Collection < Base
        include Traits::Error
        include Traits::Hint
        include Traits::Supplemental

        def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, hint:, legend:, caption:, small:, classes:, form_group:, include_hidden:, hint_method: nil, &block)
          super(builder, object_name, attribute_name, &block)

          @collection     = collection
          @value_method   = value_method
          @text_method    = text_method
          @hint_method    = hint_method
          @small          = small
          @legend         = legend
          @caption        = caption
          @hint           = hint
          @classes        = classes
          @form_group     = form_group
          @include_hidden = include_hidden
        end

        def html
          Containers::FormGroup.new(*bound, **@form_group).html do
            Containers::Fieldset.new(*bound, **fieldset_options).html do
              safe_join([supplemental_content, hint_element, error_element, check_boxes])
            end
          end
        end

      private

        def fieldset_options
          {
            legend: @legend,
            caption: @caption,
            described_by: [error_id, hint_id, supplemental_id]
          }
        end

        def check_boxes
          Containers::CheckBoxes.new(@builder, small: @small, classes: @classes).html do
            collection
          end
        end

        # Builds a collection of check {Elements::CheckBoxes::CheckBox}
        # @return [ActiveSupport::SafeBuffer] HTML output
        #
        # @note The GOV.UK design system requires that error summary links should
        #   link to the first checkbox directly. As we don't know if a collection will
        #   be rendered when it happens we need to work on the chance that it might, so
        #   the +link_errors+ variable is set to +true+ if this attribute has errors and
        #   always set back to +false+ after the first checkbox has been rendered
        def collection
          link_errors = has_errors?

          @builder.collection_check_boxes(@attribute_name, @collection, @value_method, @text_method, include_hidden: @include_hidden) do |check_box|
            Elements::CheckBoxes::CollectionCheckBox.new(
              @builder,
              @object_name,
              @attribute_name,
              check_box,
              @hint_method,
              link_errors: link_errors
            ).html.tap { link_errors = false }
          end
        end
      end
    end
  end
end
