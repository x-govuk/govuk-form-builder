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

      def html
        @builder.content_tag('div', class: %w(govuk-form-group)) do
          @builder.safe_join([
            @builder.submit(@text, class: submit_button_classes, **extra_args),
            (yield if block_given?)
          ])
        end
      end
    private

      def submit_button_classes
        %w(govuk-button).tap do |classes|
          classes.push('govuk-button--warning') if @warning
          classes.push('govuk-button--secondary') if @secondary
        end
      end

      def extra_args
        { data: { 'prevent-double-click' => (@prevent_double_click || nil) }.compact }
      end
    end
  end
end
