module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < Base
      using PrefixableArray
      include Traits::HTMLClasses
      include Traits::HTMLAttributes

      def initialize(builder, text, warning:, secondary:, prevent_double_click:, validate:, disabled:, **kwargs, &block)
        super(builder, nil, nil)

        fail ArgumentError, 'buttons can be warning or secondary' if warning && secondary

        @text                 = build_text(text)
        @prevent_double_click = prevent_double_click
        @warning              = warning
        @secondary            = secondary
        @validate             = validate
        @disabled             = disabled
        @html_attributes      = kwargs
        @block_content        = capture { block.call } if block_given?
      end

      def html
        @block_content.present? ? button_group : submit
      end

    private

      def build_text(text)
        case text
        when String
          text
        when Proc
          capture { text.call }
        else
          fail(ArgumentError, %(text must be a String or Proc))
        end
      end

      def button_group
        Containers::ButtonGroup.new(@builder, buttons).html
      end

      def buttons
        safe_join([submit, @block_content])
      end

      def submit
        @builder.tag.button(@text, **attributes(@html_attributes))
      end

      def options
        {
          type: 'submit',
          formnovalidate: !@validate,
          disabled: @disabled,
          class: classes,
          data: {
            'module' => %(#{brand}-button),
            'prevent-double-click' => @prevent_double_click
          }.select { |_k, v| v.present? }
        }
      end

      def classes
        build_classes(
          "button",
          "button--warning" => @warning,
          "button--secondary" => @secondary,
          "button--disabled" => @disabled,
        ).prefix(brand)
      end
    end
  end
end
