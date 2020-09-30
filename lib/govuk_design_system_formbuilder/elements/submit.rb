module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < Base
      using PrefixableArray

      def initialize(builder, content, warning:, secondary:, classes:, prevent_double_click:, validate:, disabled:, &block)
        fail ArgumentError, 'buttons can be warning or secondary' if warning && secondary

        @builder              = builder
        @content              = content
        @prevent_double_click = prevent_double_click
        @warning              = warning
        @secondary            = secondary
        @classes              = classes
        @validate             = validate
        @disabled             = disabled
        @block_content        = capture { block.call } if block_given?
      end

      def html
        safe_join([element, @block_content])
      end

    private

      def element
        @content.is_a?(Proc) ? button : input
      end

      def input
        @builder.submit(@content, class: classes, **options)
      end

      def button
        tag.button(class: classes, **options) { @content.call }
      end

      def classes
        %w(button)
          .prefix(brand)
          .push(warning_class, secondary_class, disabled_class, padding_class, custom_classes)
          .flatten
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

      def custom_classes
        Array.wrap(@classes)
      end
    end
  end
end
