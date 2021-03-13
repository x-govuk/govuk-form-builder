module GOVUKDesignSystemFormBuilder
  module Elements
    class Date < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Supplemental

      SEGMENTS = { day: '3i', month: '2i', year: '1i' }.freeze

      def initialize(builder, object_name, attribute_name, legend:, caption:, hint:, omit_day:, form_group:, wildcards:, date_of_birth: false, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @legend          = legend
        @caption         = caption
        @hint            = hint
        @date_of_birth   = date_of_birth
        @omit_day        = omit_day
        @form_group      = form_group
        @wildcards       = wildcards
        @html_attributes = kwargs
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name, **@form_group, **@html_attributes).html do
          Containers::Fieldset.new(@builder, @object_name, @attribute_name, **fieldset_options).html do
            safe_join([supplemental_content, hint_element, error_element, date])
          end
        end
      end

    private

      def fieldset_options
        { legend: @legend, caption: @caption, described_by: [error_id, hint_id, supplemental_id] }
      end

      def date
        tag.div(class: %(#{brand}-date-input)) do
          safe_join([day, month, year])
        end
      end

      def omit_day?
        @omit_day
      end

      def day
        return if omit_day?

        date_part(:day, width: 2, link_errors: true)
      end

      def month
        date_part(:month, width: 2, link_errors: omit_day?)
      end

      def year
        date_part(:year, width: 4)
      end

      def date_part(segment, width:, link_errors: false)
        value = @builder.object.try(@attribute_name).try(segment)

        tag.div(class: %(#{brand}-date-input__item)) do
          tag.div(class: %(#{brand}-form-group)) do
            safe_join([label(segment, link_errors), input(segment, link_errors, width, value)])
          end
        end
      end

      def label(segment, link_errors)
        tag.label(
          segment.capitalize,
          class: label_classes,
          for: id(segment, link_errors)
        )
      end

      def input(segment, link_errors, width, value)
        tag.input(
          id: id(segment, link_errors),
          class: classes(width),
          name: name(segment),
          type: 'text',
          pattern: pattern(segment),
          inputmode: 'numeric',
          value: value,
          autocomplete: date_of_birth_autocomplete_value(segment)
        )
      end

      def pattern(segment)
        return '[0-9X]*' if @wildcards && segment.in?(%i(day month))

        '[0-9]*'
      end

      def classes(width)
        %w(input date-input__input).prefix(brand).tap do |classes|
          classes.push(%(#{brand}-input--width-#{width}))
          classes.push(%(#{brand}-input--error)) if has_errors?
        end
      end

      # if the field has errors we want the govuk_error_summary to
      # be able to link to the day field. Otherwise, generate IDs
      # in the normal fashion
      def id(segment, link_errors)
        if has_errors? && link_errors
          field_id(link_errors: link_errors)
        else
          [@object_name, @attribute_name, SEGMENTS.fetch(segment)].join("_")
        end
      end

      def name(segment)
        format(
          "%<object_name>s[%<input_name>s(%<segment>s)]",
          object_name: @object_name,
          input_name: @attribute_name,
          segment: SEGMENTS.fetch(segment)
        )
      end

      def date_of_birth_autocomplete_value(segment)
        return unless @date_of_birth

        { day: 'bday-day', month: 'bday-month', year: 'bday-year' }.fetch(segment)
      end

      def label_classes
        %w(label date-input__label).prefix(brand)
      end
    end
  end
end
