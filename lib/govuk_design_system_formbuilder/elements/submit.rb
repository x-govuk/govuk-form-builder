module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < Base
      using PrefixableArray

      def initialize(builder, text, warning:, secondary:, classes:, prevent_double_click:, validate:, disabled:, &block)
        fail ArgumentError, 'buttons can be warning or secondary' if warning && secondary

        @builder              = builder
        @text                 = text
        @prevent_double_click = prevent_double_click
        @warning              = warning
        @secondary            = secondary
        @classes              = classes
        @validate             = validate
        @disabled             = disabled
        @block_content        = capture { block.call } if block_given?
      end

      def html
        safe_join([submit, @block_content])
      end

    private

      def submit
        @builder.submit(@text, class: submit_classes, **submit_options)
      end

      def submit_classes
        %w(button)
          .prefix(brand)
          .push(warning_class, secondary_class, disabled_class, @classes, padding_class(@block_content.present?))
          .compact
      end

      def submit_options
        {
          formnovalidate: !@validate,
          disabled: @disabled,
          data: {
            module: %(#{brand}-button),
            'prevent-double-click': @prevent_double_click
          }.select { |_k, v| v.present? }
        }
      end

      def warning_class
        %(#{brand}-button--warning) if @warning
      end

      def secondary_class
        %(#{brand}-button--secondary) if @secondary
      end

      def padding_class(content_present)
        %(#{brand}-!-margin-right-1) if content_present
      end

      def disabled_class
        %(#{brand}-button--disabled) if @disabled
      end
    end
  end
end
