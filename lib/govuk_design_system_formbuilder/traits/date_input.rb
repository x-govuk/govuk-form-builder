module GOVUKDesignSystemFormBuilder
  module Traits
    module DateInput
      using PrefixableArray

      MULTIPARAMETER_KEY = { year: 1, month: 2, day: 3, hour: 4, minute: 5, second: 6 }.freeze
      SEGMENT_METHOD = { year: :year, month: :month, day: :day, hour: :hour, minute: :min, second: :sec }.freeze

      def html
        Containers::FormGroup.new(*bound, **@form_group, **@html_attributes).html do
          Containers::Fieldset.new(*bound, **fieldset_options).html do
            safe_join([supplemental_content, hint_element, error_element, date_input])
          end
        end
      end

    private

      def date_input
        tag.div(class: %(#{brand}-date-input)) do
          safe_join(parts)
        end
      end

      def maxlength_enabled?
        @maxlength_enabled
      end

      def fieldset_options
        { legend: @legend, caption: @caption, described_by: [error_id, hint_id, supplemental_id] }
      end

      def segment_label_text(segment)
        localised_text(:label, segment) || @segment_names.fetch(segment)
      end

      def classes(width)
        build_classes(
          %(input),
          %(date-input__input),
          %(input--width-#{width}),
          %(input--error) => has_errors?,
        ).prefix(brand)
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

        if attribute.respond_to?(:fetch)
          attribute.fetch(MULTIPARAMETER_KEY[segment]) do
            warn("No key '#{segment}' found in MULTIPARAMETER_KEY hash. Expected to find #{MULTIPARAMETER_KEY.values}")

            nil
          end
        elsif attribute.respond_to?(SEGMENT_METHOD[segment])
          attribute.send(SEGMENT_METHOD.fetch(segment))
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

      def input(segment, link_errors, width, value)
        tag.input(
          id: id(segment, link_errors),
          class: classes(width),
          name: name(segment),
          type: 'text',
          inputmode: 'numeric',
          value:,
          autocomplete: autocomplete_value(segment),
          maxlength: (width if maxlength_enabled?),
        )
      end

      # if the field has errors we want the govuk_error_summary to
      # be able to link to the hour field. Otherwise, generate IDs
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

      def label_classes
        build_classes(%(label), %(date-input__label)).prefix(brand)
      end
    end
  end
end
