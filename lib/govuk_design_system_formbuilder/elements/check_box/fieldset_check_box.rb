module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBox
      class FieldsetCheckBox < Radio
        def initialize(builder, object_name, attribute_name, value, label:, hint:)
          super(builder, object_name, attribute_name)
          @value = value
          @label = label
          @hint  = hint
        end

        def html(&block)
          @conditional_content, @conditional_id = process(block)

          @builder.content_tag('div', class: 'govuk-checkboxes__item') do
            @builder.safe_join(
              [
                input,
                Elements::Label.new(
                  @builder,
                  @object_name,
                  @attribute_name,
                  **@label.merge(
                    value: @value.parameterize,
                    text: @value
                  )
                ).html,
                Elements::Hint.new(@builder, @object_name, @attribute_name, id: hint_id, class: check_box_hint_classes, text: @hint).html,
                conditional_content
              ]
            )
          end
        end

      private

        def input
          @builder.check_box(
            @attribute_name,
            id: attribute_descriptor,
            class: check_box_classes,
            aria: { describedby: hint_id },
            data: { 'aria-controls' => @conditional_id }
          )
        end

        def conditional_content
          return nil unless @conditional_content.present?

          @builder.content_tag('div', class: conditional_classes, id: @conditional_id) do
            @conditional_content
          end
        end

        def process(block)
          return content = block.call, (content && conditional_id)
        end

        def conditional_classes
          %w(govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden)
        end

        def hint_id
          return nil unless @hint.present?

          [@object_name, @attribute_name, @value, 'hint'].join('-').parameterize
        end

        def check_box_classes
          %w(govuk-checkbox)
        end

        def check_box_hint_classes
          %w(govuk-hint govuk-checkboxes__hint)
        end
      end
    end
  end
end
