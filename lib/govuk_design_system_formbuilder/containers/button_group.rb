module GOVUKDesignSystemFormBuilder
  module Containers
    class ButtonGroup < Base
      def initialize(builder, buttons)
        super(builder, nil, nil)

        @buttons = buttons
      end

      def html
        tag.div(@buttons, class: %(#{brand}-button-group))
      end
    end
  end
end
