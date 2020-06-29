module GOVUKDesignSystemFormBuilder
  module Containers
    class Radios < Base
      using PrefixableArray

      include Traits::Hint

      def initialize(builder, inline:, small:, classes:)
        @builder = builder
        @inline  = inline
        @small   = small
        @classes = classes
      end

      def html
        content_tag('div', **radios_options) do
          yield
        end
      end

    private

      def radios_options
        {
          class: radios_classes,
          data: { module: %(#{brand}-radios) }
        }
      end

      def radios_classes
        %w(radios).prefix(brand).tap do |c|
          c.push(%(#{brand}-radios--inline)) if @inline
          c.push(%(#{brand}-radios--small))  if @small
          c.push(@classes)                   if @classes
        end
      end
    end
  end
end
