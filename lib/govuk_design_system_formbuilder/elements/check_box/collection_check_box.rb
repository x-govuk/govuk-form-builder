module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBox
      class CollectionCheckBox < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, checkbox, hint_method = nil)
          @builder  = builder
          @checkbox = checkbox
          @item     = checkbox.object
          @hint     = @item.send(hint_method) if hint_method.present?
        end

        def html
          @builder.content_tag('div', class: 'govuk-checkboxes__item') do
            @builder.safe_join(
              [
                @checkbox.check_box(class: "govuk-checkboxes_input"),
                Label.new(@checkbox).html,
                Hint.new(@builder, @hint).html
              ]
            )
          end
        end
      end
    end
  end
end
