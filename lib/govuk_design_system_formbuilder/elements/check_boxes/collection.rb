module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class Collection < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, hint_method: nil, hint_text:, legend:, small:, &block)
          super(builder, object_name, attribute_name)

          @collection    = collection
          @value_method  = value_method
          @text_method   = text_method
          @hint_method   = hint_method
          @small         = small
          @legend        = legend
          @hint_text     = hint_text
          @block_content = @builder.capture { block.call } if block_given?
        end

        def html
          hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text)
          error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

          Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
            Containers::Fieldset.new(@builder, legend: @legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
              @builder.safe_join(
                [
                  hint_element.html,
                  error_element.html,
                  @block_content,
                  Containers::CheckBoxes.new(@builder, small: @small).html do
                    build_collection
                  end
                ]
              )
            end
          end
        end

      private

        # Builds a collection of check {Elements::CheckBoxes::CheckBox}
        # @return [ActiveSupport::SafeBuffer] HTML output
        #
        # @note The GOV.UK design system requires that error summary links should
        #   link to the first checkbox directly. As we don't know if a collection will
        #   be rendered when it happens we need to work on the chance that it might, so
        #   the +link_errors+ variable is set to +true+ if this attribute has errors and
        #   always set back to +false+ after the first checkbox has been rendered
        def build_collection
          link_errors = has_errors?

          @builder.collection_check_boxes(@attribute_name, @collection, @value_method, @text_method) do |check_box|
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
