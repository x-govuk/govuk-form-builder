module GOVUKDesignSystemFormBuilder
  module Traits
    module Input
      def initialize(builder, object_name, attribute_name, hint_text:, label:, caption:, width:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @width           = width
        @label           = label
        @caption         = caption
        @hint_text       = hint_text
        @html_attributes = kwargs
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, input])
        end
      end

    private

      def input
        @builder.send(builder_method, @attribute_name, **input_options, **@html_attributes)
      end

      def input_options
        {
          id: field_id(link_errors: true),
          class: input_classes,
          aria: { describedby: described_by(hint_id, error_id, supplemental_id) }
        }
      end

      def input_classes
        [%(#{brand}-input)].push(width_classes, error_classes).compact
      end

      def error_classes
        %(#{brand}-input--error) if has_errors?
      end

      def width_classes
        return if @width.blank?

        case @width

          # fixed (character) widths
        when 20 then %(#{brand}-input--width-20)
        when 10 then %(#{brand}-input--width-10)
        when 5  then %(#{brand}-input--width-5)
        when 4  then %(#{brand}-input--width-4)
        when 3  then %(#{brand}-input--width-3)
        when 2  then %(#{brand}-input--width-2)

          # fluid widths
        when 'full'           then %(#{brand}-!-width-full)
        when 'three-quarters' then %(#{brand}-!-width-three-quarters)
        when 'two-thirds'     then %(#{brand}-!-width-two-thirds)
        when 'one-half'       then %(#{brand}-!-width-one-half)
        when 'one-third'      then %(#{brand}-!-width-one-third)
        when 'one-quarter'    then %(#{brand}-!-width-one-quarter)

        else fail(ArgumentError, "invalid width '#{@width}'")
        end
      end
    end
  end
end
