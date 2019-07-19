module GOVUKDesignSystemFormBuilder
  module Elements
    class CollectionCheckBoxes < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, collection, value_method, text_method, hint_method = nil, hint_text:, legend:, small:, &block)
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

      def build_collection
        @builder.collection_check_boxes(@attribute_name, @collection, @value_method, @text_method) do |check_box|
          Elements::CheckBoxes::CollectionCheckBox.new(@builder, @attribute_name, check_box, @hint_method).html
        end
      end
    end
  end
end
