module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      def initialize(builder, small:, classes: nil)
        super(builder, nil, nil)

        @small   = small
        @classes = classes
      end

      def html(&block)
        tag.div(**options, &block)
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
