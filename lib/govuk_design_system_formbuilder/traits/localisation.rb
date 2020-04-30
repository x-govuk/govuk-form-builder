module GOVUKDesignSystemFormBuilder
  module Traits
    module Localisation
    private

      def localised_text(context)
        key = localisation_key(context)

        # `I18n.exists?(nil)` returns true when `config.i18n.fallbacks` is
        # enabled, so only proceed if the key is present too
        return nil unless key.present? && I18n.exists?(key)

        I18n.translate(key)
      end

      def localisation_key(context)
        return nil unless @object_name.present? && @attribute_name.present?

        schema(context)
      end

      def schema(context)
        schema_root(context)
          .push(@object_name, @attribute_name)
          .map { |e| e == :__context__ ? context : e }
          .join('.')
      end

      def schema_root(context)
        contextual_schema = case context
                            when :legend
                              config.localisation_schema_legend
                            when :hint
                              config.localisation_schema_hint
                            when :label
                              config.localisation_schema_label
                            end

        (contextual_schema || config.localisation_schema_fallback).dup
      end
    end
  end
end
