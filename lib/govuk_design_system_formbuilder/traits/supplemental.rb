module GOVUKDesignSystemFormBuilder
  module Traits
    module Supplemental
      def supplemental_id
        return if @block_content.blank?

        build_id('supplemental')
      end

    private

      def supplemental_content
        @supplemental_content ||= Containers::Supplemental.new(@builder, @object_name, @attribute_name, @block_content)
      end
    end
  end
end
