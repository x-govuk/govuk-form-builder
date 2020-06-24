module GOVUKDesignSystemFormBuilder
  module Elements
    class Date < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Supplemental

      SEGMENTS = { day: '3i', month: '2i', year: '1i' }.freeze

      def initialize(builder, object_name, attribute_name, legend:, caption:, hint_text:, date_of_birth: false, omit_day:, &block)
        super(builder, object_name, attribute_name, &block)

        @legend        = legend
        @caption       = caption
        @hint_text     = hint_text
        @date_of_birth = date_of_birth
        @omit_day      = omit_day
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, @object_name, @attribute_name, legend: @legend, caption: @caption, described_by: [error_id, hint_id, supplemental_id]).html do
            safe_join([supplemental_content, hint_element, error_element, date])
          end
        end
      end

    private

      def date
        content_tag('div', class: %(#{brand}-date-input)) do
          safe_join([day, month, year])
        end
      end

      def omit_day?
        @omit_day
      end

      def day
        return nil if omit_day?

        date_part_input(:day, link_errors: true)
      end

      def month
        date_part_input(:month, link_errors: omit_day?)
      end

      def year
        date_part_input(:year, width: 4)
      end

      def date_part_input(segment, width: 2, link_errors: false)
        value = @builder.object.try(@attribute_name).try(segment)

        content_tag('div', class: %w(date-input__item).prefix(brand)) do
          content_tag('div', class: %w(form-group).prefix(brand)) do
            safe_join(
              [
                tag.label(
                  segment.capitalize,
                  class: date_part_label_classes,
                  for: date_part_attribute_id(segment, link_errors)
                ),

                tag.input(
                  id: date_part_attribute_id(segment, link_errors),
                  class: date_part_input_classes(width),
                  name: date_part_attribute_name(segment),
                  type: 'text',
                  pattern: '[0-9]*',
                  inputmode: 'numeric',
                  value: value,
                  autocomplete: date_of_birth_autocomplete_value(segment)
                )
              ]
            )
          end
        end
      end

      def date_part_input_classes(width)
        %w(input date-input__input).prefix(brand).tap do |classes|
          classes.push(%(#{brand}-input--width-#{width}))
          classes.push(%(#{brand}-input--error)) if has_errors?
        end
      end

      def date_part_label_classes
        %w(label date-input__label).prefix(brand)
      end

      # if the field has errors we want the govuk_error_summary to
      # be able to link to the day field. Otherwise, generate IDs
      # in the normal fashion
      def date_part_attribute_id(segment, link_errors)
        if has_errors? && link_errors
          field_id(link_errors: link_errors)
        else
          [@object_name, @attribute_name, SEGMENTS.fetch(segment)].join("_")
        end
      end

      def date_part_attribute_name(segment)
        format(
          "%<object_name>s[%<attribute_name>s(%<segment>s)]",
          object_name: @object_name,
          attribute_name: @attribute_name,
          segment: SEGMENTS.fetch(segment)
        )
      end

      def date_of_birth_autocomplete_value(segment)
        return nil unless @date_of_birth

        { day: 'bday-day', month: 'bday-month', year: 'bday-year' }.fetch(segment)
      end
    end
  end
end
