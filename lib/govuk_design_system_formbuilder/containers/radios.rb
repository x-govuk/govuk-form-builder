module GOVUKDesignSystemFormBuilder
  module Containers
    class Radios < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, inline:)
        @builder = builder
        @inline = inline
      end

      def html
        @builder.content_tag('div', class: radios_classes, data: { module: 'radios' }) do
          yield
        end
      end
    private

      def radios_classes
        %w(govuk-radios).tap do |c|
          c.push('govuk-radios--inline') if @inline
        end
      end
    end
  end
end
