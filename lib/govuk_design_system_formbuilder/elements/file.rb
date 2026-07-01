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
      include Traits::DataAttributesI18n

      def initialize(builder, object_name, attribute_name, hint:, label:, caption:, form_group:, javascript:, before_input:, after_input:, choose_files_button_text:, drop_instruction_text:, multiple_files_chosen_text:, multiple_files_chosen_one_text:, multiple_files_chosen_other_text:, no_file_chosen_text:, entered_drop_zone_text:, left_drop_zone_text:, **kwargs, &block)
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
        @multiple_files_chosen_one_text = multiple_files_chosen_one_text
        @multiple_files_chosen_other_text = multiple_files_chosen_other_text
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
        tag.div(class: "#{brand}-file-upload-wrapper", data: { module: "#{brand}-file-upload" }, **i18n_data) { file }
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          aria: { describedby: combine_references(hint_id, error_id) }
        }
      end

      def classes
        build_classes(%(file-upload), %(file-upload--error) => has_errors?).prefix(brand)
      end

      def i18n_data
        attrs = [
          I18nAttr.new("data-i18n.choose-files-button",         @choose_files_button_text,         :default_file_choose_files_button_text),
          I18nAttr.new("data-i18n.drop-instruction",            @drop_instruction_text,            :default_file_drop_instruction_text),
          I18nAttr.new("data-i18n.no-file-chosen",              @no_file_chosen_text,              :default_file_no_file_chosen_text),
          I18nAttr.new("data-i18n.multiple-files-chosen.one",   @multiple_files_chosen_one_text,   :default_file_multiple_files_chosen_one_text),
          I18nAttr.new("data-i18n.multiple-files-chosen.other", @multiple_files_chosen_other_text, :default_file_multiple_files_chosen_other_text),
          I18nAttr.new("data-i18n.entered-drop-zone",           @entered_drop_zone_text,           :default_file_entered_drop_zone),
          I18nAttr.new("data-i18n.left-drop-zone",              @left_drop_zone_text,              :default_file_left_drop_zone)
        ]

        # deal with the Nunjucks stlye hash format as an alternative
        if @multiple_files_chosen_text.is_a?(Hash)
          if (text = @multiple_files_chosen_text.symbolize_keys[:other])
            attrs << I18nAttr.new("data-i18n.multiple-files-chosen.other", text, :default_file_multiple_files_chosen_other_text)
          end

          if (text = @multiple_files_chosen_text.symbolize_keys[:one])
            attrs << I18nAttr.new("data-i18n.multiple-files-chosen.one", text, :default_file_multiple_files_chosen_one_text)
          end
        end

        build_data_attr_hash(attrs)
      end
    end
  end
end
