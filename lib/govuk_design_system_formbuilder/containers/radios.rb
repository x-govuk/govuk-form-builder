module GOVUKDesignSystemFormBuilder
  module Containers
    class Radios < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, inline:, small:)
        @builder = builder
        @inline  = inline
        @small   = small
      end

      def html
        @builder.content_tag('div', class: radios_classes, data: { module: 'govuk-radios' }) do
          yield
        end
      end

    private

      def radios_classes
        %w(govuk-radios).tap do |c|
          c.push('govuk-radios--inline') if @inline
          c.push('govuk-radios--small')  if @small
        end
      end
    end
  end
end
