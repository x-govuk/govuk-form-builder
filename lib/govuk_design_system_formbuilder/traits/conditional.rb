module GOVUKDesignSystemFormBuilder
  module Traits
    module Conditional
      def conditional_id
        build_id('conditional')
      end

      def wrap_conditional(block)
        content_tag('div', class: conditional_classes, id: conditional_id) do
          capture { block.call }
        end
      end
    end
  end
end
