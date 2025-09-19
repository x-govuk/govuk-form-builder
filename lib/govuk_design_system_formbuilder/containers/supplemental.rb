module GOVUKDesignSystemFormBuilder
  module Containers
    class Supplemental < Base
      def initialize(builder, object_name, attribute_name, content)
        super(builder, object_name, attribute_name)

        @content = content
      end

      def html
        return if @content.blank?

        tag.div { @content }
      end
    end
  end
end
