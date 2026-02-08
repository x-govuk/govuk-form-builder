module GOVUKDesignSystemFormBuilder
  module Traits
    module ContentBeforeAndAfter
      def before_input_content
        build_content(@before_input)
      end

      def after_input_content
        build_content(@after_input)
      end

    private

      def build_content(content)
        case content
        when String
          content
        when Proc
          content.call
        end
      end
    end
  end
end
