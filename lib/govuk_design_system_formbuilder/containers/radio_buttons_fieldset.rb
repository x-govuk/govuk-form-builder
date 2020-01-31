module GOVUKDesignSystemFormBuilder
  module Containers
    class RadioButtonsFieldset < Base
      include Traits::Hint
      include Traits::Error

      def initialize(builder, object_name, attribute_name, hint_text:, legend:, inline:, small:, classes:, &block)
        super(builder, object_name, attribute_name)

        @inline        = inline
        @small         = small
        @legend        = legend
        @hint_text     = hint_text
        @classes       = classes
        @block_content = capture { block.call }
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, @object_name, @attribute_name, legend: @legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
            safe_join(
              [
                hint_element.html,
                error_element.html,
                Containers::Radios.new(@builder, inline: @inline, small: @small, classes: @classes).html do
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
