module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      def initialize(builder, small:, classes: nil)
        @builder = builder
        @small   = small
        @classes = classes
      end

      def html
        content_tag('div', **options) do
          yield
        end
      end

    private

      def options
        {
          class: classes,
          data: { module: %(#{brand}-checkboxes) }
        }
      end

      def classes
        [%(#{brand}-checkboxes), small_class, @classes].compact
      end

      def small_class
        %(#{brand}-checkboxes--small) if @small
      end
    end
  end
end
