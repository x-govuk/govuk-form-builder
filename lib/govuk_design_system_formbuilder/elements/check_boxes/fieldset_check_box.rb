module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class FieldsetCheckBox < Base
        include Traits::Label
        include Traits::Hint
        include Traits::HTMLAttributes
        include Traits::FieldsetItem

        def initialize(builder, object_name, attribute_name, value, unchecked_value, label:, hint:, link_errors:, multiple:, exclusive:, **kwargs, &block)
          super(builder, object_name, attribute_name, &block)

          @value           = value
          @unchecked_value = unchecked_value
          @label           = label
          @hint            = hint
          @multiple        = multiple
          @link_errors     = link_errors
          @html_attributes = kwargs
          @exclusive       = exclusive

          conditional_content(@block_content)
        end

      private

        def input_type
          :checkboxes
        end

        def input
          @builder.check_box(@attribute_name, attributes(@html_attributes.deep_merge(exclusive_options)), @value, @unchecked_value)
        end

        def fieldset_options
          { checkbox: true }
        end

        def exclusive_options
          return {} unless @exclusive

          { data: { behaviour: 'exclusive' } }
        end
      end
    end
  end
end
