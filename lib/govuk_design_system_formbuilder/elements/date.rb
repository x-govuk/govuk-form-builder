module GOVUKDesignSystemFormBuilder
  module Elements
    class Date < GOVUKDesignSystemFormBuilder::Base
      SEGMENTS = { day: '3i', month: '2i', year: '1i' }.freeze

      def initialize(builder, object_name, attribute_name, legend:, hint_text:, date_of_birth: false, &block)
        super(builder, object_name, attribute_name, &block)
        @legend = legend
        @hint_text = hint_text
        @date_of_birth = date_of_birth
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          Containers::Fieldset.new(@builder, legend: @legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
            @builder.safe_join(
              [
                hint_element.html,
                error_element.html,
                supplemental_content.html,
                @builder.content_tag('div', class: 'govuk-date-input') do
                  @builder.safe_join(
                    [
                      date_input_item(:day, link_errors: true),
                      date_input_item(:month),
                      date_input_item(:year, width: 4)
                    ]
                  )
                end
              ]
            )
          end
        end
      end

    private

      def date_input_item(segment, width: 2, link_errors: false)
        value = @builder.object.try(@attribute_name).try(segment)

        @builder.content_tag('div', class: %w(govuk-date-input__item)) do
          @builder.content_tag('div', class: %w(govuk-form-group)) do
            @builder.safe_join(
              [
                @builder.tag.label(
                  segment.capitalize,
                  class: date_input_label_classes,
                  for: date_attribute_id(segment, link_errors)
                ),

                @builder.tag.input(
                  id: date_attribute_id(segment, link_errors),
                  class: date_input_classes(width),
                  name: date_attribute_name(segment),
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

      def date_input_classes(width)
        %w(govuk-input govuk-date-input__input).tap do |classes|
          classes.push("govuk-input--width-#{width}")
          classes.push("govuk-input--error") if has_errors?
        end
      end

      def date_input_label_classes
        %w(govuk-label govuk-date-input__label)
      end

      # if the field has errors we want the govuk_error_summary to
      # be able to link to the day field. Otherwise, generate IDs
      # in the normal fashion
      def date_attribute_id(segment, link_errors)
        if has_errors? && link_errors
          field_id(link_errors: link_errors)
        else
          [@object_name, @attribute_name, SEGMENTS.fetch(segment)].join("_")
        end
      end

      def date_attribute_name(segment)
        "%<object_name>s[%<attribute_name>s(%<segment>s)]" % {
          object_name: @object_name,
          attribute_name: @attribute_name,
          segment: SEGMENTS.fetch(segment)
        }
      end

      def date_of_birth_autocomplete_value(segment)
        return nil unless @date_of_birth

        { day: 'bday-day', month: 'bday-month', year: 'bday-year' }.fetch(segment)
      end
    end
  end
end
