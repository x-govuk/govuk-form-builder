module GOVUKDesignSystemFormBuilder
  module Containers
    class Radios < Base
      include Traits::Hint

      def initialize(builder, inline:, small:, classes:)
        @builder = builder
        @inline  = inline
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
          data: { module: %(#{brand}-radios) }
        }
      end

      def classes
        [%(#{brand}-radios), inline_class, small_class, @classes].compact
      end

      def inline_class
        %(#{brand}-radios--inline) if @inline
      end

      def small_class
        %(#{brand}-radios--small)  if @small
      end
    end
  end
end
