module GOVUKDesignSystemFormBuilder
  module Elements
    class Date < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Supplemental
      include Traits::HTMLClasses
      include Traits::Localisation

      MULTIPARAMETER_KEY = { day: 3, month: 2, year: 1 }.freeze

      def initialize(builder, object_name, attribute_name, legend:, caption:, hint:, omit_day:, maxlength_enabled:, segments:, form_group:, segment_names:, date_of_birth: false, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @legend            = legend
        @caption           = caption
        @hint              = hint
        @date_of_birth     = date_of_birth
        @omit_day          = omit_day
        @maxlength_enabled = maxlength_enabled
        @segments          = segments
        @segment_names     = segment_names
        @form_group        = form_group
        @html_attributes   = kwargs
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group, **@html_attributes).html do
          Containers::Fieldset.new(*bound, **fieldset_options).html do
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

      def maxlength_enabled?
        @maxlength_enabled
      end

      def day
        if omit_day?
          return tag.input(
            id: id(:day, false),
            name: name(:day),
            type: 'hidden',
            value: value(:day) || 1,
          )
        end

        date_part(:day, width: 2, link_errors: true)
      end

      def month
        date_part(:month, width: 2, link_errors: omit_day?)
      end

      def year
        date_part(:year, width: 4)
      end

      def date_part(segment, width:, link_errors: false)
        tag.div(class: %(#{brand}-date-input__item)) do
          tag.div(class: %(#{brand}-form-group)) do
            safe_join([label(segment, link_errors), input(segment, link_errors, width, value(segment))])
          end
        end
      end

      def value(segment)
        attribute = @builder.object.try(@attribute_name)

        return unless attribute

        if attribute.respond_to?(segment)
          attribute.send(segment)
        elsif attribute.respond_to?(:fetch)
          attribute.fetch(MULTIPARAMETER_KEY[segment]) do
            warn("No key '#{segment}' found in MULTIPARAMETER_KEY hash. Expected to find #{MULTIPARAMETER_KEY.values}")

            nil
          end
        else
          fail(ArgumentError, "invalid Date-like object: must be a Date, Time, DateTime or Hash in MULTIPARAMETER_KEY format")
        end
      end

      def label(segment, link_errors)
        tag.label(
          segment_label_text(segment),
          class: label_classes,
          for: id(segment, link_errors)
        )
      end

      def segment_label_text(segment)
        localised_text(:label, segment) || @segment_names.fetch(segment)
      end

      def input(segment, link_errors, width, value)
        tag.input(
          id: id(segment, link_errors),
          class: classes(width),
          name: name(segment),
          type: 'text',
          inputmode: 'numeric',
          value:,
          autocomplete: date_of_birth_autocomplete_value(segment),
          maxlength: (width if maxlength_enabled?),
        )
      end

      def classes(width)
        build_classes(
          %(input),
          %(date-input__input),
          %(input--width-#{width}),
          %(input--error) => has_errors?,
        ).prefix(brand)
      end

      # if the field has errors we want the govuk_error_summary to
      # be able to link to the day field. Otherwise, generate IDs
      # in the normal fashion
      def id(segment, link_errors)
        if has_errors? && link_errors
          field_id(link_errors:)
        else
          [@object_name, @attribute_name, @segments.fetch(segment)].join("_")
        end
      end

      def name(segment)
        format(
          "%<object_name>s[%<input_name>s(%<segment>s)]",
          object_name: @object_name,
          input_name: @attribute_name,
          segment: @segments.fetch(segment)
        )
      end

      def date_of_birth_autocomplete_value(segment)
        return unless @date_of_birth

        { day: 'bday-day', month: 'bday-month', year: 'bday-year' }.fetch(segment)
      end

      def label_classes
        build_classes(%(label), %(date-input__label)).prefix(brand)
      end
    end
  end
end
