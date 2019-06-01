module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, **args, &block)
        super(builder, object_name, attribute_name)

        @aria_described_by = args.dig(:aria_described_by)
      end

      def html
        @builder.content_tag(
          :select,
          class: 'govuk-select',
          name: attribute_identifier,
          aria: { describedby: @aria_described_by }
        ) do
          yield
        end
      end
    end
  end
end

