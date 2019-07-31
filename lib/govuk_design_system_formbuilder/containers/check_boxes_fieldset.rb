module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxesFieldset < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, hint_text:, legend:, small:, &block)
        super(builder, object_name, attribute_name)

        @legend        = legend
        @hint_text     = hint_text
        @small         = small
        @block_content = @builder.capture { block.call }
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, legend: @legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
            @builder.safe_join(
              [
                hint_element.html,
                error_element.html,
                Containers::CheckBoxes.new(@builder, small: @small).html do
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
