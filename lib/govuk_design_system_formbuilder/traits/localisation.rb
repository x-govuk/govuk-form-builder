module GOVUKDesignSystemFormBuilder
  module Traits
    module Localisation
      # starts with an letter that is followed by other word characters or
      # spaces, zero or more times
      BASE_NAME_REGEXP = %r{[[:alpha:]](?:[\w\s]*)}

      # empty, or starting with `[`, indicating that the root form's @object_name is likely blank
      EMPTY_SCOPE_REGEXP = %r{\A\z|\A\[}

      def localised_text(context, segment = nil)
        return unless localisation_object_name.present? && @attribute_name.present?

        full_context = [schema(context), segment].compact.join('.')

        localise(full_context) || localise_html(full_context)
      end

    private

      # The name used as the base of the localisation key. This is normally the
      # object name, but forms that submit flat params (e.g. search or filter
      # forms built with +scope: ""+) have a blank root object name, and fields
      # nested within them have names like +[address]+. For these forms we
      # localise as if the form were scoped to the root object's
      # +model_name.i18n_key+, so +[address]+ becomes +person_filter[address]+.
      def localisation_object_name
        # pre-check, avoid walking the builder chain when @object_name is defined
        return @object_name unless EMPTY_SCOPE_REGEXP.match?(@object_name)

        root_builder = @builder
        root_builder = root_builder.options[:parent_builder] while root_builder.options[:parent_builder]

        return @object_name unless root_builder.object_name == ""

        # replace the blank scope/param_key with the root form object's i18n key
        object = root_builder.object
        object = object.to_model if object.respond_to?(:to_model)
        object.respond_to?(:model_name) ? "#{object.model_name.i18n_key}#{@object_name}" : @object_name
      end

      def localise(context)
        I18n.translate(context, default: nil)
      end

      def localise_html(context)
        I18n.translate("#{context}_html", default: nil).try(:html_safe)
      end

      def schema(context)
        schema_root(context)
          .push(*schema_path)
          .map { |e| e == :__context__ ? context : e }
          .join('.')
      end

      def schema_path
        base_object_name = if config.enable_nested_localisation
                             localisation_object_name.to_s.scan(BASE_NAME_REGEXP).join(".")
                           else
                             localisation_object_name
                           end

        if @value.present?
          [base_object_name, "#{@attribute_name}_options", @value]
        else
          [base_object_name, @attribute_name]
        end
      end

      def schema_root(context)
        contextual_schema = case context
                            when :legend
                              config.localisation_schema_legend
                            when :hint
                              config.localisation_schema_hint
                            when :label
                              config.localisation_schema_label
                            when :caption
                              config.localisation_schema_caption
                            end

        (contextual_schema || config.localisation_schema_fallback).dup
      end
    end
  end
end
