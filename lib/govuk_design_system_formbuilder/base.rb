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
    def field_id(link_errors = true)
      if link_errors && has_errors?
        build_id('field-error', include_value: false)
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

    # Builds the values used for HTML id attributes throughout the builder
    #
    # @param id_type [String] a description of the id's type, eg +hint+, +error+
    # @param delimiter [String] the characters used to 'split' the output
    # @param replace [String] the targets to be replaced by the delimiter
    # @param attribute_name [String] overrides the object's +@attribute_name+
    # @param include_value [Boolean] controls whether or not the value will form part
    #   of the final id
    #
    # @return [String] the id composed of object, attribute, value and type
    #
    # @example
    #   build_id('hint') #=> "person-name-hint"
    def build_id(id_type, delimiter = '-', replace = '_', attribute_name: nil, include_value: true)
      attribute = attribute_name || @attribute_name
      value     = include_value && @value
      [
        @object_name,
        attribute,
        value,
        id_type
      ]
        .compact
        .join(delimiter)
        .parameterize
        .tr(replace, delimiter)
    end
  end
end
