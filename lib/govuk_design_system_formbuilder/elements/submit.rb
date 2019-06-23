module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, text, warning:, secondary:, prevent_double_click:)
        @builder              = builder
        @text                 = text
        @prevent_double_click = prevent_double_click

        fail ArgumentError, 'buttons can be warning or secondary' if (warning && secondary)
        @warning = warning
        @secondary = secondary
      end

      def html(&block)
        content = process(block)

        @builder.content_tag('div', class: %w(govuk-form-group)) do
          @builder.safe_join([
            @builder.submit(@text, class: submit_button_classes(content.present?), **extra_args),
            content
          ])
        end
      end
    private

      def submit_button_classes(content_present)
        %w(govuk-button).tap do |classes|
          classes.push('govuk-button--warning') if @warning
          classes.push('govuk-button--secondary') if @secondary

          # NOTE only this input will receive a right margin, block
          # contents must be addressed individually
          classes.push('govuk-!-margin-right-1') if content_present
        end
      end

      def extra_args
        { data: { 'prevent-double-click' => (@prevent_double_click || nil) }.compact }
      end

      def process(block)
        block.call
      end
    end
  end
end
