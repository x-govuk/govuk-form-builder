module GOVUKDesignSystemFormBuilder
  module Containers
    class RadioButtonsFieldset < Base
      include Traits::Hint
      include Traits::Error

      def initialize(builder, object_name, attribute_name, hint:, legend:, caption:, inline:, small:, form_group:, **kwargs, &block)
        fail LocalJumpError, 'no block given' unless block_given?

        super(builder, object_name, attribute_name, &block)

        @inline          = inline
        @small           = small
        @legend          = legend
        @caption         = caption
        @hint            = hint
        @form_group      = form_group
        @html_attributes = kwargs
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          Containers::Fieldset.new(*bound, **fieldset_options).html do
            safe_join([hint_element, error_element, radios])
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

      def radios
        Containers::Radios.new(@builder, inline: @inline, small: @small, **@html_attributes).html do
          @block_content
        end
      end
    end
  end
end
