module GOVUKDesignSystemFormBuilder
  module Elements
    class Input < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, attribute_type:, hint_text:, label:, **extra_args)
        super(builder, object_name, attribute_name)

        @extra_args     = extra_args.dup
        @width          = @extra_args.delete(:width)
        @builder_method = [attribute_type, 'field'].join('_')
        @label          = label
        @hint_text      = hint_text
      end

      def html
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text)
        label_element = Elements::Label.new(@builder, @object_name, @attribute_name, @label)
        error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          @builder.safe_join(
            [
              label_element.html,
              hint_element.html,
              error_element.html,
              @builder.send(
                @builder_method,
                @attribute_name,
                class: input_classes,
                aria: {
                  describedby: [
                    hint_element.hint_id,
                    error_element.error_id
                  ].compact.join(' ').presence
                },
                **@extra_args
              )
            ]
          )
        end
      end

    private

      def input_classes
        %w(govuk-input).tap do |classes|
          classes.push(width_classes)
          classes.push('govuk-input--error') if has_errors?
        end
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
