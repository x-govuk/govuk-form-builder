module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, **args)
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
          yield if block_given?
        end
      end
    end
  end
end
