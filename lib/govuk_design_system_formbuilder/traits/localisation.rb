module GOVUKDesignSystemFormBuilder
  module Traits
    module Localisation
      # starts with an letter that is followed by other word characters or
      # spaces, zero or more times
      BASE_NAME_REGEXP = %r{[[:alpha:]](?:[\w\s]*)}

    private

      def localised_text(context)
        return unless @object_name.present? && @attribute_name.present?

        localise(context) || localise_html(context)
      end

      def localise(context)
        I18n.translate(schema(context), default: nil)
      end

      def localise_html(context)
        I18n.translate("#{schema(context)}_html", default: nil).try(:html_safe)
      end

      def schema(context)
        schema_root(context)
          .push(*schema_path)
          .map { |e| e == :__context__ ? context : e }
          .join('.')
      end

      def schema_path
        base_object_name = if config.enable_nested_localisation
                             @object_name.to_s.scan(BASE_NAME_REGEXP).join(".")
                           else
                             @object_name
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
