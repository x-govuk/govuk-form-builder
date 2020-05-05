module GOVUKDesignSystemFormBuilder
  module Traits
    module Input
      def initialize(builder, object_name, attribute_name, hint_text:, label:, width:, **extra_args, &block)
        super(builder, object_name, attribute_name, &block)

        @width          = width
        @extra_args     = extra_args
        @label          = label
        @hint_text      = hint_text
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          safe_join(
            [
              label_element.html,
              supplemental_content.html,
              hint_element.html,
              error_element.html,
              @builder.send(
                builder_method,
                @attribute_name,
                id: field_id(link_errors: true),
                class: input_classes,
                aria: {
                  describedby: described_by(
                    hint_id,
                    error_id,
                    supplemental_id
                  )
                },
                **@extra_args
              )
            ]
          )
        end
      end

    private

      def input_classes
        %w(govuk-input).push(width_classes, error_classes).compact
      end

      def error_classes
        'govuk-input--error' if has_errors?
      end

      def width_classes
        return if @width.blank?

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

        else fail(ArgumentError, "invalid width '#{@width}'")
        end
      end
    end
  end
end
