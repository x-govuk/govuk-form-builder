module GOVUKDesignSystemFormBuilder
  module Containers
    class Supplemental < Base
      def initialize(builder, object_name, attribute_name, content)
        super(builder, object_name, attribute_name)

        @content = content
      end

      def html
        return if @content.blank?

        warn("Supplemental content is deprecated and support will soon be removed. See https://github.com/x-govuk/govuk-form-builder/issues/445")

        tag.div(id: supplemental_id) { @content }
      end

    private

      def supplemental_id
        build_id('supplemental')
      end
    end
  end
end
