module GOVUKDesignSystemFormBuilder
  module BuilderHelper
    def govuk_field_id(object, object_name, attribute_name, value: nil, link_errors: true)
      proxy_base(object, object_name, attribute_name, value: value).field_id(link_errors: link_errors)
    end

    def govuk_error_summary(object, object_name, *args, **kwargs)
      proxy_builder(object, object_name, self, {}).govuk_error_summary(*args, **kwargs)
    end

  private

    def proxy_base(object, object_name, attribute_name, value: nil)
      GOVUKDesignSystemFormBuilder::Proxy.new(object, object_name, attribute_name, value: value)
    end

    def proxy_builder(object, object_name, template, options)
      GOVUKDesignSystemFormBuilder::FormBuilderProxy.new(object_name, object, template, options)
    end
  end
end
