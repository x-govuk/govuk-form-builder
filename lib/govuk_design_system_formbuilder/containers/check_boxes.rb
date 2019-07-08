module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      def initialize(builder, small:)
        @builder = builder
        @small   = small
      end

      def html
        @builder.content_tag('div', class: check_boxes_classes, data: { module: 'checkboxes' }) do
          yield
        end
      end

    private

      def check_boxes_classes
        %w(govuk-checkboxes).tap do |c|
          c.push('govuk-checkboxes--small') if @small
        end
      end
    end
  end
end
