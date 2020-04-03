module GOVUKDesignSystemFormBuilder
  module Elements
    class Select < Base
      include Traits::Error
      include Traits::Label
      include Traits::Hint
      include Traits::Supplemental

      def initialize(builder, object_name, attribute_name, collection, value_method:, text_method:, options: {}, html_options: {}, hint_text:, label:, &block)
        super(builder, object_name, attribute_name, &block)

        @collection    = collection
        @value_method  = value_method
        @text_method   = text_method
        @options       = options
        @html_options  = html_options
        @label         = label
        @hint_text     = hint_text
      end

      def html
        Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
          safe_join(
            [
              label_element.html,
              supplemental_content.html,
              hint_element.html,
              error_element.html,
              @builder.collection_select(
                @attribute_name,
                @collection,
                @value_method,
                @text_method,
                @options,
                build_html_options
              )
            ]
          )
        end
      end

    private

      def build_html_options
        @html_options.deep_merge(
          id: field_id(link_errors: true),
          class: select_classes,
          aria: { describedby: described_by(hint_id, error_id, supplemental_id) }
        )
      end

      def select_classes
        %w(govuk-select).tap do |classes|
          classes.push('govuk-select--error') if has_errors?
        end
      end
    end
  end
end
