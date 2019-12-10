module GOVUKDesignSystemFormBuilder
  module Traits
    module Localisation
      def localised_text(context)
        key = localisation_key(context)

        return nil unless I18n.exists?(key)

        I18n.translate(key)
      end

      def localisation_key(context)
        return nil unless @object_name.present? && @attribute_name.present?

        ['helpers', context, @object_name, @attribute_name].join('.')
      end
    end
  end
end
