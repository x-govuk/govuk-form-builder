module GOVUKDesignSystemFormBuilder
  module Elements
    module Traits
      module CollectionItem
      private

        def retrieve(item, text_method)
          case text_method
          when Symbol, String
            item.send(text_method)
          when Proc
            text_method.call(item)
          end
        end
      end
    end
  end
end
