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
        content_tag('div', class: radios_classes, data: { module: 'govuk-radios' }) do
          yield
        end
      end

    private

      def radios_classes
        %w(govuk-radios).tap do |c|
          c.push('govuk-radios--inline') if @inline
          c.push('govuk-radios--small')  if @small
          c.push(@classes)               if @classes
        end
      end
    end
  end
end
