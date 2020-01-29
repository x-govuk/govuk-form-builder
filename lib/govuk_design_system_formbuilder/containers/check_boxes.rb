module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      def initialize(builder, small:, classes: nil)
        @builder = builder
        @small   = small
        @classes = classes
      end

      def html
        content_tag('div', class: check_boxes_classes, data: { module: 'govuk-checkboxes' }) do
          yield
        end
      end

    private

      def check_boxes_classes
        %w(govuk-checkboxes).tap do |c|
          c.push('govuk-checkboxes--small') if @small
          c.push(@classes) if @classes
        end
      end
    end
  end
end
