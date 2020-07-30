module GOVUKDesignSystemFormBuilder
  module Traits
    module Conditional
    private

      def conditional_id
        build_id('conditional')
      end

      def wrap_conditional(block)
        tag.div(class: conditional_classes, id: conditional_id) { block.call }
      end
    end
  end
end
