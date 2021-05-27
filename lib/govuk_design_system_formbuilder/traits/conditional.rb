module GOVUKDesignSystemFormBuilder
  module Traits
    module Conditional
    private

      def conditional_id
        build_id('conditional')
      end

      def wrap_conditional(block)
        block_result = block.call
        return if block_result.blank?

        tag.div(class: conditional_classes, id: conditional_id) do
          capture { block_result }
        end
      end
    end
  end
end
