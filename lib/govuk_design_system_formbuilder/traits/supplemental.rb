module GOVUKDesignSystemFormBuilder
  module Traits
    module Supplemental
    private

      def supplemental_content
        @supplemental_content ||= Containers::Supplemental.new(*bound, @block_content)
      end
    end
  end
end
