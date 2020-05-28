module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      using PrefixableArray

      def initialize(builder, small:, classes: nil)
        @builder = builder
        @small   = small
        @classes = classes
      end

      def html
        content_tag('div', class: check_boxes_classes, data: { module: %(#{brand}-checkboxes) }) do
          yield
        end
      end

    private

      def check_boxes_classes
        %w(checkboxes).prefix(brand).tap do |c|
          c.push(%(#{brand}-checkboxes--small)) if @small
          c.push(@classes) if @classes
        end
      end
    end
  end
end
