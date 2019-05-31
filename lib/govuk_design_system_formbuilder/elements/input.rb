module GOVUKDesignSystemFormBuilder
  module Elements
    class Input < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, options = {})
        @builder = builder
        @object_name = object_name
        @attribute_name = attribute_name

        default_options.merge(options).tap do |o|
          @field_type = o.dig(:field_type)
          @aria_described_by = o.dig(:aria_described_by)
        end
      end

      def html
        @builder.tag.input(
          class: 'govuk-input',
          type: @field_type,
          name: attribute_identifier,
          aria: {
            describedby: @aria_described_by
          }
        )
      end

    private

      def default_options
        {}
      end
    end
  end
end
