module GOVUKDesignSystemFormBuilder
  module PrefixableArray
    refine Array do
      def prefix(text, delimiter: '-')
        map { |item| [text, item].join(delimiter.to_s) }
      end
    end
  end
end
