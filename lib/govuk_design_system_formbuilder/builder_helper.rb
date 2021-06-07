module GOVUKDesignSystemFormBuilder
  # NOTE: this is currently considered experimental, it's likely to change based on feedback.
  #
  # BuilderHelper contains methods that expose the form builder's functionality
  # externally. The objectives are to allow:
  #
  # * rendering the error summary outside of the form
  #
  # * setting the id of custom form elements (rich text editors, date pickers,
  #   sliders, etc) using the formbuilder's internal logic, allowing them to be
  #   linked from the error summary
  module BuilderHelper
    # Returns the form builder generated id for an object's attribute, allowing
    # users to force their custom element ids to match those that'll be generated
    # by the error summary.
    # @param object [ActiveRecord::Base,ActiveModel::Model,Object] the object that we want to
    #   generate an id for
    # @param object_name [Symbol] the object's name, the singular version of the object's class
    #   name, e.g., +Person+ is +:person+.
    # @param attribute_name [Symbol] the attribute we're generating an id for
    # @param value [Object] the value of the attribute. Only necessary for fields with
    #   multiple form elements like radio buttons and checkboxes
    # @param link_errors [Boolean] toggles whether or not to override the field id with the
    #   error id when there are errors on the +object+. Only relevant for radio buttons
    #   and check boxes.
    def govuk_field_id(object, attribute_name, object_name = nil, value: nil, link_errors: true)
      (object_name = retrieve_object_name(object)) if object_name.nil?

      proxy_base(object, object_name, attribute_name, value: value).field_id(link_errors: link_errors)
    end

    # Renders an error summary
    # @param object [ActiveRecord::Base,ActiveModel::Model,Object] the object we'll be rendering
    #   the errors for
    # @param object_name [Symbol] the object's name, the singular version of the object's class
    #   name, e.g., +Person+ is +:person+. If none is supplied we'll try to infer it from
    #   the object, so it'll probably be necessary for regular Ruby objects
    # @option args [Array] options passed through to the builder's +#govuk_error_summary+
    # @option kwargs [Hash] keyword options passed through to the builder's +#govuk_error_summary+
    #
    # @example
    #   = govuk_error_summary(@registration)
    #
    # @see https://design-system.service.gov.uk/components/error-summary/ GOV.UK error summary
    def govuk_error_summary(object, object_name = nil, *args, **kwargs)
      (object_name = retrieve_object_name(object)) if object_name.nil?

      proxy_builder(object, object_name, self, {}).govuk_error_summary(*args, **kwargs)
    end

  private

    def proxy_base(object, object_name, attribute_name, value: nil)
      GOVUKDesignSystemFormBuilder::Proxy.new(object, object_name, attribute_name, value: value)
    end

    def proxy_builder(object, object_name, template, options)
      GOVUKDesignSystemFormBuilder::FormBuilderProxy.new(object_name, object, template, options)
    end

    def retrieve_object_name(object)
      object.to_model.model_name.singular
    end
  end
end
