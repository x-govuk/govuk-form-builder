module GOVUKDesignSystemFormBuilder
  module Containers
    class Radios < Base
      include Traits::Hint

      def initialize(builder, inline:, small:, classes:)
        super(builder, nil, nil)

        @builder = builder
        @inline  = inline
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
          data: { module: %(#{brand}-radios) }
        }
      end

      def classes
        [%(#{brand}-radios), inline_class, small_class, custom_classes].flatten.compact
      end

      def inline_class
        %(#{brand}-radios--inline) if @inline
      end

      def small_class
        %(#{brand}-radios--small)  if @small
      end

      def custom_classes
        Array.wrap(@classes)
      end
    end
  end
end
