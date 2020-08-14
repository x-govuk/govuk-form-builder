module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxesFieldset < Base
      include Traits::Error
      include Traits::Hint

      def initialize(builder, object_name, attribute_name, hint:, legend:, caption:, small:, classes:, form_group:, &block)
        super(builder, object_name, attribute_name, &block)

        @legend        = legend
        @caption       = caption
        @hint          = hint
        @small         = small
        @classes       = classes
        @form_group    = form_group
        @block_content = block.call
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name, **@form_group).html do
          Containers::Fieldset.new(@builder, @object_name, @attribute_name, **fieldset_options).html do
            safe_join([hint_element, error_element, checkboxes])
          end
        end
      end

    private

      def fieldset_options
        {
          legend: @legend,
          caption: @caption,
          described_by: [error_element.error_id, hint_element.hint_id]
        }
      end

      def checkboxes
        Containers::CheckBoxes.new(@builder, small: @small, classes: @classes).html do
          @block_content
        end
      end
    end
  end
end
