module GOVUKDesignSystemFormBuilder
  module Traits
    module CollectionItem
    private

      def retrieve(item, method)
        case method
        when Symbol, String
          item.send(method)
        when Proc
          capture { method.call(item).to_s }
        end
      end
    end
  end
end
