module GOVUKDesignSystemFormBuilder
  module Elements
    class Date < GOVUKDesignSystemFormBuilder::Base
      SEGMENTS = { day: '3i', month: '2i', year: '1i' }

      def initialize(builder, object_name, attribute_name, legend:, hint:)
        super(builder, object_name, attribute_name)
        @legend = legend
        @hint = hint
      end

      def html
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint)

        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, @object_name, @attribute_name, legend: @legend, described_by: hint_element.hint_id).html do
            @builder.safe_join(
              [
                hint_element.html,
                (yield if block_given?),
                @builder.content_tag('div', class: 'govuk-date-input') do
                  @builder.safe_join(
                    [
                      date_input_group(:day, min: 1, max: 31),
                      date_input_group(:month, min: 1, max: 12),
                      # FIXME there must be more sensible defaults than this!
                      date_input_group(:year, min: 1900, max: 2100, width: 4)
                    ]
                  )
                end
              ]
            )
          end
        end
      end

    private

      def date_input_group(segment, min:, max:, width: 2)
        value = @builder.object.try(@attribute_name).try(segment)

        @builder.content_tag('div', class: %w(govuk-date-input__item)) do
          @builder.content_tag('div', class: %w(govuk-form-group)) do
            @builder.safe_join(
              [
                @builder.tag.label(
                  segment.capitalize,
                  class: date_input_label_classes,
                  for: date_attribute_descriptor(segment)
                ),

                @builder.tag.input(
                  id: date_attribute_descriptor(segment),
                  class: date_input_classes(width),
                  for: date_attribute_identifier(segment),
                  type: 'number',
                  min: min,
                  max: max,
                  step: 1,
                  value: value
                )
              ]
            )
          end
        end
      end

      def date_input_classes(width)
        %w(govuk-input govuk-date-input__input).push("govuk-input--width-#{width}")
      end

      def date_input_label_classes
        %w(govuk-label govuk-date-input__label)
      end

      def date_attribute_descriptor(segment)
        [@object_name, @attribute_name, SEGMENTS.fetch(segment)].join("_")
      end

      def date_attribute_identifier(segment)
        "%<object_name>s[%<attribute_name>s(%<segment>s)]" % {
          object_name: @object_name,
          attribute_name: @attribute_name,
          segment: SEGMENTS.fetch(segment)
        }
      end
    end
  end
end
