module GOVUKDesignSystemFormBuilder
  module Containers
    class CheckBoxes < Base
      def initialize(builder)
        @builder = builder
      end

      def html
        @builder.content_tag('div', class: 'govuk-checkboxes', data: { module: 'checkboxes' }) do
          yield
        end
      end
    end
  end
end
