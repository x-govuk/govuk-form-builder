module GOVUKDesignSystemFormBuilder
  module Containers
    class Fieldset < GOVUKDesignSystemFormBuilder::Base
      LEGEND_DEFAULTS = { text: nil, tag: 'h1', size: 'm' }.freeze
      LEGEND_SIZES = %w(xl l m s).freeze

      def initialize(builder, legend: {}, described_by: nil)
        @builder = builder
        @legend = LEGEND_DEFAULTS.merge(legend)
        @described_by = described_by(described_by)
      end

      def html
        content_tag('fieldset', class: fieldset_classes, aria: { describedby: @described_by }) do
          safe_join([build_legend, yield])
        end
      end

    private

      def build_legend
        if legend_text.present?
          content_tag('legend', class: legend_classes) do
            tag.send(@legend.dig(:tag), legend_text, class: legend_heading_classes)
          end
        end
      end

      def legend_text
        [@legend.dig(:text), localised_text('fieldset')].compact.first
      end

      def fieldset_classes
        %w(govuk-fieldset)
      end

      def legend_classes
        size = @legend.dig(:size)
        fail "invalid size '#{size}', must be #{LEGEND_SIZES.join(', ')}" unless size.in?(LEGEND_SIZES)

        ["govuk-fieldset__legend", "govuk-fieldset__legend--#{size}"]
      end

      def legend_heading_classes
        %(govuk-fieldset__heading)
      end
    end
  end
end
