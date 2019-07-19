module GOVUKDesignSystemFormBuilder
  class Base
    def initialize(builder, object_name, attribute_name)
      @builder = builder
      @object_name = object_name
      @attribute_name = attribute_name
    end

    def html
      fail 'should be overridden'
    end

    # returns the id value used for the input
    #
    # @note field_id is overridden so that the error summary can link to the
    #   correct element.
    #
    #   It's straightforward for inputs with a single element (like a textarea
    #   or text input) but the GOV.UK Design System requires that the error
    #   summary link to the first checkbox or radio in a list, so additional
    #   logic is requred
    #
    # @return [String] the element's +id+
    # @see https://design-system.service.gov.uk/components/error-summary/#linking-from-the-error-summary-to-each-answer
    #   GOV.UK linking to elements from the error summary
    def field_id
      if has_errors?
        build_id('field-error')
      else
        build_id('field')
      end
    end

    def hint_id
      return nil if @hint_text.blank?

      build_id('hint')
    end

    def error_id
      return nil unless has_errors?

      build_id('error')
    end

    def conditional_id
      build_id('conditional')
    end

    def has_errors?
      @builder.object.errors.any? &&
        @builder.object.errors.messages.dig(@attribute_name).present?
    end

    def attribute_identifier
      "%<object_name>s[%<attribute_name>s]" % {
        object_name: @object_name,
        attribute_name: @attribute_name
      }
    end

    def wrap_conditional(block)
      @builder.content_tag('div', class: conditional_classes, id: conditional_id) do
        @builder.capture { block.call }
      end
    end

  private

    def build_id(id_type, delimiter = '-', replace = '_', override_attribute_name: nil)
      [
        @object_name,
        (override_attribute_name || @attribute_name),
        @value,
        id_type
      ]
        .compact
        .join(delimiter)
        .parameterize
        .tr(replace, delimiter)
    end
  end
end
