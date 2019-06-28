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

      [@object_name, @attribute_name, @value, 'hint'].compact.join('-').parameterize
    end

    def error_id
      return nil unless has_errors?

      [@object_name, @attribute_name, 'error'].join('-').parameterize
    end

    def conditional_id
      [@object_name, @attribute_name, @value, 'conditional'].compact.join('-').parameterize
    end

    def has_errors?
      @builder.object.invalid? &&
        @builder.object.errors.messages.keys.include?(@attribute_name)
    end

    def attribute_descriptor
      [@object_name, @attribute_name, @value].compact.join('_').parameterize
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
  end
end
