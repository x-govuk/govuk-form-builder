module GOVUKDesignSystemFormBuilder
  module BuilderHelper
    def govuk_design_system_formbuilder_field_id(object, object_name, attribute_name, value: nil, link_errors: true)
      proxy(object, object_name, attribute_name, value: value).field_id(link_errors: link_errors)
    end

  private

    def proxy(object, object_name, attribute_name, value: nil)
      GOVUKDesignSystemFormBuilder::Proxy.new(object, object_name, attribute_name, value: value)
    end
  end
end
