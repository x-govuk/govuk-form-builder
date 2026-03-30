module GOVUKDesignSystemFormBuilder
  module Elements
    class File < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental
      include Traits::HTMLAttributes
      include Traits::HTMLClasses
      include Traits::ContentBeforeAndAfter

      def initialize(builder, object_name, attribute_name, hint:, label:, caption:, form_group:, javascript:, before_input:, after_input:, choose_files_button_text:, drop_instruction_text:, multiple_files_chosen_text:, no_file_chosen_text:, entered_drop_zone_text:, left_drop_zone_text:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label = label
        @caption = caption
        @hint = hint
        @html_attributes = kwargs
        @form_group = form_group
        @javascript = javascript
        @before_input = before_input
        @after_input = after_input

        @choose_files_button_text = choose_files_button_text
        @drop_instruction_text = drop_instruction_text
        @multiple_files_chosen_text = multiple_files_chosen_text
        @no_file_chosen_text = no_file_chosen_text
        @entered_drop_zone_text = entered_drop_zone_text
        @left_drop_zone_text = left_drop_zone_text
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, before_input_content, file_html, after_input_content])
        end
      end

    private

      def file_html
        @javascript ? file_with_javascript_markup : file
      end

      def file
        @builder.file_field(@attribute_name, attributes(@html_attributes))
      end

      def file_with_javascript_markup
        tag.div(class: "#{brand}-drop-zone", data: { module: "#{brand}-file-upload" }, **i18n_data) { file }
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: combine_references(hint_id, error_id, supplemental_id) }
        }
      end

      def classes
        build_classes(%(file-upload), %(file-upload--error) => has_errors?).prefix(brand)
      end

      def i18n_data
        data = {
          "data-i18n.choose-files-button" => @choose_files_button_text,
          "data-i18n.drop-instruction" => @drop_instruction_text,
          "data-i18n.no-file-chosen" => @no_file_chosen_text,
          "data-i18n.entered-drop-zone" => @entered_drop_zone_text,
          "data-i18n.left-drop-zone" => @left_drop_zone_text,
        }

        if @multiple_files_chosen_text.is_a?(Hash)
          @multiple_files_chosen_text.each do |key, value|
            data["data-i18n.multiple-files-chosen.#{key}"] = value
          end
        end

        data.compact
      end
    end
  end
end
