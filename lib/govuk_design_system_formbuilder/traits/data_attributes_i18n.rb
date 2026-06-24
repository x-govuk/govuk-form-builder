module GOVUKDesignSystemFormBuilder
  module Traits
    module DataAttributesI18n
      I18nAttr = Struct.new(:data_attribute_key, :text, :config_key) do
        def default
          GOVUKDesignSystemFormBuilder.config[config_key]
        end
      end

    private

      def build_data_attr_hash(attrs)
        attrs.each_with_object({}) do |attr, h|
          text = attr.text || attr.default

          h[attr.data_attribute_key] = text unless govuk_default?(attr.config_key, text)
        end
      end

      def govuk_default?(key, value)
        GOVUKDesignSystemFormBuilder::GOVUK_FRONTEND_DEFAULTS.fetch(key) == value
      end
    end
  end
end
