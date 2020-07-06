module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      def initialize(builder, small:, classes: nil)
        @builder = builder
        @small   = small
        @classes = classes
      end

      def html
        content_tag('div', **options) { yield }
      end

    private

      def options
        {
          class: classes,
          data: { module: %(#{brand}-checkboxes) }
        }
      end

      def classes
        [%(#{brand}-checkboxes), small_class, custom_classes].flatten.compact
      end

      def small_class
        %(#{brand}-checkboxes--small) if @small
      end

      def custom_classes
        Array.wrap(@classes)
      end
    end
  end
end
