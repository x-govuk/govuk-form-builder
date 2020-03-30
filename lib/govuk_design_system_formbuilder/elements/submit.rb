module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < Base
      def initialize(builder, text, warning:, secondary:, prevent_double_click:, validate:, &block)
        fail ArgumentError, 'buttons can be warning or secondary' if warning && secondary

        @builder              = builder
        @text                 = text
        @prevent_double_click = prevent_double_click
        @warning              = warning
        @secondary            = secondary
        @validate             = validate
        @block_content        = capture { block.call } if block_given?
      end

      def html
        safe_join(
          [
            @builder.submit(
              @text,
              class: %w(govuk-button).push(
                warning_class,
                secondary_class,
                padding_class(@block_content.present?)
              ).compact,
              **extra_args
            ),
            @block_content
          ]
        )
      end

    private

      def warning_class
        'govuk-button--warning' if @warning
      end

      def secondary_class
        'govuk-button--secondary' if @secondary
      end

      def padding_class(content_present)
        'govuk-!-margin-right-1' if content_present
      end

      def extra_args
        {
          formnovalidate: !@validate,
          data: {
            module: 'govuk-button',
            'prevent-double-click' => @prevent_double_click
          }.select { |_k, v| v.present? }
        }
      end
    end
  end
end
