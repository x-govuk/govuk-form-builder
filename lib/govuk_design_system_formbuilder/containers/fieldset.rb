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
        tag.fieldset(**options) do
          safe_join([legend_element, (@block_content || yield)])
        end
      end

    private

      def options
        {
          class: classes,
          aria: { describedby: @described_by }
        }
      end

      def classes
        %(#{brand}-fieldset)
      end

      def legend_element
        @legend_element ||= if @legend.nil?
                              Elements::Null.new
                            else
                              Elements::Legend.new(@builder, @object_name, @attribute_name, **legend_options)
                            end
      end

      def legend_options
        { legend: @legend, caption: @caption }
      end
    end
  end
end
