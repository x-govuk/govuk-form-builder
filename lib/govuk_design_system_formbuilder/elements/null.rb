module GOVUKDesignSystemFormBuilder
  module Elements
    class Null < Base
      def initialize
        super(nil, nil, nil)
      end

      def html
        nil
      end

      def active?
        false
      end

      def hint_id
        nil
      end
    end
  end
end
