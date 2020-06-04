module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxesFieldset < Base
      include Traits::Error
      include Traits::Hint

      def initialize(builder, object_name, attribute_name, hint_text:, legend:, caption:, small:, classes:, &block)
        super(builder, object_name, attribute_name, &block)

        @legend        = legend
        @caption       = caption
        @hint_text     = hint_text
        @small         = small
        @classes       = classes
        @block_content = capture { block.call }
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, @object_name, @attribute_name, legend: @legend, caption: @caption, described_by: [error_element.error_id, hint_element.hint_id]).html do
            safe_join(
              [
                hint_element.html,
                error_element.html,
                Containers::CheckBoxes.new(@builder, small: @small, classes: @classes).html do
                  @block_content
                end
              ]
            )
          end
        end
      end
    end
  end
end
