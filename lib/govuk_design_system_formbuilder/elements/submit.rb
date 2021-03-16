module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < Base
      using PrefixableArray
      include Traits::HTMLAttributes

      def initialize(builder, text, warning:, secondary:, classes:, prevent_double_click:, validate:, disabled:, **kwargs, &block)
        super(builder, nil, nil)

        fail ArgumentError, 'buttons can be warning or secondary' if warning && secondary

        @text                 = text
        @prevent_double_click = prevent_double_click
        @warning              = warning
        @secondary            = secondary
        @classes              = classes
        @validate             = validate
        @disabled             = disabled
        @html_attributes      = kwargs
        @block_content        = capture { block.call } if block_given?
      end

      def html
        @block_content.present? ? button_group : buttons
      end

    private

      def buttons
        safe_join([submit, @block_content])
      end

      def button_group
        Containers::ButtonGroup.new(@builder, buttons).html
      end

      def submit
        @builder.submit(@text, class: classes, **attributes(@html_attributes))
      end

      def classes
        %w(button)
          .prefix(brand)
          .push(warning_class, secondary_class, disabled_class, custom_classes)
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

      def disabled_class
        %(#{brand}-button--disabled) if @disabled
      end

      def custom_classes
        Array.wrap(@classes)
      end
    end
  end
end
