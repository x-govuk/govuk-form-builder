module GOVUKDesignSystemFormBuilder
  module Containers
    class Supplemental < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, content)
        @builder        = builder
        @object_name    = object_name
        @attribute_name = attribute_name
        @content        = content
      end

      def html
        return nil if @content.blank?

        content_tag('div', id: supplemental_id) do
          @content
        end
      end

      def supplemental_id
        build_id('supplemental')
      end
    end
  end
end
