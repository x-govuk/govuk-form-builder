module GOVUKDesignSystemFormBuilder
  module Containers
    class ButtonGroup < Base
      def initialize(builder, buttons, brand:)
        super(builder, nil, nil, brand)

        @buttons = buttons
      end

      def html
        tag.div(@buttons, class: %(#{brand}-button-group))
      end
    end
  end
end
