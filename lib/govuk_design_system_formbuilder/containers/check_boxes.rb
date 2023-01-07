module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      include Traits::HTMLClasses
      include Traits::HTMLAttributes

      def initialize(builder, small:, **kwargs)
        super(builder, nil, nil)

        @small = small
        @html_attributes = kwargs
      end

      def html(&block)
        tag.div(**attributes(@html_attributes), &block)
      end

    private

      def options
        {
          class: classes,
          data: { module: %(#{brand}-checkboxes) }
        }
      end

      def classes
        build_classes(
          %(#{brand}-checkboxes),
          %(#{brand}-checkboxes--small) => @small,
        )
      end
    end
  end
end
