module GOVUKDesignSystemFormBuilder
  module Traits
    module Conditional
    private

      def conditional_id
        build_id('conditional')
      end

      def wrap_conditional(content)
        tag.div(class: conditional_classes, id: conditional_id) do
          capture { content }
        end
      end
    end
  end
end
