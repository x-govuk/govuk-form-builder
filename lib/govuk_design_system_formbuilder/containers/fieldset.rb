module GOVUKDesignSystemFormBuilder
  module Containers
    class Fieldset < Base
      def initialize(builder, object_name = nil, attribute_name = nil, legend: {}, caption: {}, described_by: nil, &block)
        super(builder, object_name, attribute_name, &block)

        @legend         = legend
        @caption        = caption
        @described_by   = described_by(described_by)
        @attribute_name = attribute_name
      end

      def html
        content_tag('fieldset', **fieldset_options) do
          safe_join([legend_element, (@block_content || yield)])
        end
      end

    private

      def fieldset_options
        {
          class: fieldset_classes,
          aria: { describedby: @described_by }
        }
      end

      def fieldset_classes
        %(#{brand}-fieldset)
      end

      def legend_element
        @legend_element ||= Elements::Legend.new(@builder, @object_name, @attribute_name, **legend_options)
      end

      def legend_options
        { legend: @legend, caption: @caption }
      end
    end
  end
end
