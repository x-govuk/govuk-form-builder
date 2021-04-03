module GOVUKDesignSystemFormBuilder
  module Containers
    class Fieldset < Base
      include Traits::HTMLAttributes

      def initialize(builder, object_name = nil, attribute_name = nil, legend: {}, caption: {}, described_by: nil, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @legend          = legend
        @caption         = caption
        @described_by    = described_by(described_by)
        @attribute_name  = attribute_name
        @html_attributes = kwargs
      end

      def html
        tag.fieldset(**attributes(@html_attributes)) do
          safe_join([legend_element, (@block_content || yield)])
        end
      end

    private

      def options
        {
          class: classes,
          aria: { describedby: [@described_by] }
        }
      end

      def classes
        [%(#{brand}-fieldset)]
      end

      def legend_element
        @legend_element ||= if @legend.nil?
                              Elements::Null.new
                            else
                              Elements::Legend.new(*bound, **legend_options)
                            end
      end

      def legend_options
        case @legend
        when Hash
          @legend.merge(caption: @caption)
        when Proc
          { content: @legend }
        else
          fail(ArgumentError, %(legend must be a Proc or Hash))
        end
      end
    end
  end
end
