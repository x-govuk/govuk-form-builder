module GOVUKDesignSystemFormBuilder
  module Containers
    class Fieldset < Base
      include Traits::Localisation

      LEGEND_SIZES = %w(xl l m s).freeze

      def initialize(builder, object_name = nil, attribute_name = nil, legend: {}, described_by: nil)
        super(builder, object_name, attribute_name)

        @legend         = legend_defaults.merge(legend)
        @described_by   = described_by(described_by)
        @attribute_name = attribute_name
      end

      def html
        content_tag('fieldset', class: fieldset_classes, aria: { describedby: @described_by }) do
          safe_join([build_legend, yield])
        end
      end

    private

      def legend_defaults
        {
          hidden: false,
          text: nil,
          tag:  config.default_legend_tag,
          size: config.default_legend_size
        }
      end

      def build_legend
        if legend_text.present?
          content_tag('legend', class: legend_classes) do
            tag.send(@legend.dig(:tag), legend_text, class: legend_heading_classes)
          end
        end
      end

      def legend_text
        [@legend.dig(:text), localised_text(:legend)].compact.first
      end

      def fieldset_classes
        %w(govuk-fieldset)
      end

      def legend_classes
        size = @legend.dig(:size)
        fail "invalid size '#{size}', must be #{LEGEND_SIZES.join(', ')}" unless size.in?(LEGEND_SIZES)

        classes = %W(govuk-fieldset__legend govuk-fieldset__legend--#{size})
        classes.push('govuk-visually-hidden') if @legend.dig(:hidden)

        classes
      end

      def legend_heading_classes
        %(govuk-fieldset__heading)
      end
    end
  end
end
