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
        @builder.submit(@text, class: classes, **options)
      end

      def classes
        %w(button)
          .prefix(brand)
          .push(warning_class, secondary_class, disabled_class, padding_class, @classes)
          .compact
      end

      def options
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

      def padding_class
        %(#{brand}-!-margin-right-1) if @block_content
      end

      def disabled_class
        %(#{brand}-button--disabled) if @disabled
      end
    end
  end
end
