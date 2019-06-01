module GOVUKDesignSystemFormBuilder
  module Elements
    class Input < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, **args)
        super(builder, object_name, attribute_name)

        args.tap do |o|
          @field_type = o.dig(:field_type)
          @aria_described_by = o.dig(:aria_described_by)
          @width = o.dig(:width)
        end
      end

      def html
        @builder.tag.input(
          class: input_classes,
          type: @field_type,
          name: attribute_identifier,
          aria: {
            describedby: @aria_described_by
          }
        )
      end

    private

    def input_classes
      %w(govuk-input).push(width_classes).compact
    end

    def width_classes
      return unless @width.present?

      case @width
        # fixed (character) widths
      when 20 then 'govuk-input--width-20'
      when 10 then 'govuk-input--width-10'
      when 5  then 'govuk-input--width-5'
      when 4  then 'govuk-input--width-4'
      when 3  then 'govuk-input--width-3'
      when 2  then 'govuk-input--width-2'

        # fluid widths
      when 'full'           then 'govuk-!-width-full'
      when 'three-quarters' then 'govuk-!-width-three-quarters'
      when 'two-thirds'     then 'govuk-!-width-two-thirds'
      when 'one-half'       then 'govuk-!-width-one-half'
      when 'one-third'      then 'govuk-!-width-one-third'
      when 'one-quarter'    then 'govuk-!-width-one-quarter'

      else fail "invalid width #{@width}"
      end
    end

    end
  end
end
