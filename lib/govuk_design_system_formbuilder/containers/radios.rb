module GOVUKDesignSystemFormBuilder
  module Containers
    class Radios < Base
      include Traits::Hint
      include Traits::HTMLAttributes
      include Traits::HTMLClasses

      def initialize(builder, inline:, small:, **kwargs)
        super(builder, nil, nil)

        @inline          = inline
        @small           = small
        @html_attributes = kwargs
      end

      def html(&block)
        tag.div(**attributes(@html_attributes), &block)
      end

    private

      def options
        {
          class: classes,
          data: { module: %(#{brand}-radios) }
        }
      end

      def classes
        build_classes(
          %(#{brand}-radios),
          %(#{brand}-radios--inline) => @inline,
          %(#{brand}-radios--small) => @small,
        )
      end
    end
  end
end
