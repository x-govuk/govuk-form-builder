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

    def hint_id
      return nil unless @hint_text.present?

      build_id('hint')
    end

    def error_id
      return nil unless has_errors?

      build_id('error')
    end

    def conditional_id
      build_id('conditional')
    end

    def attribute_descriptor
      build_id(nil, '_', '-')
    end

    def has_errors?
      @builder.object.invalid? &&
        @builder.object.errors.messages.keys.include?(@attribute_name)
    end

    def attribute_identifier
      "%<object_name>s[%<attribute_name>s]" % {
        object_name: @object_name,
        attribute_name: @attribute_name
      }
    end

    def wrap_conditional(block)
      conditional = @builder.content_tag('div', class: conditional_classes, id: conditional_id) do
        @builder.capture { block.call }
      end
      return conditional, conditional_id
    end

  private

    def build_id(id_type, delimiter = '-', replace = '_')
      [@object_name, @attribute_name, @value, id_type]
        .compact
        .join(delimiter)
        .parameterize
        .tr(replace, delimiter)
    end
  end
end
