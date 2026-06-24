module GOVUKDesignSystemFormBuilder
  module Elements
    class Password < Base
      using PrefixableArray
      using HTMLAttributesUtils

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::HTMLAttributes
      include Traits::HTMLClasses
      include Traits::DataAttributesI18n

      def initialize(builder, object_name, attribute_name, label:, caption:, hint:, form_group:, show_password_text:, hide_password_text:, show_password_aria_label_text:, hide_password_aria_label_text:, password_hidden_announcement_text:, password_shown_announcement_text:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label           = label
        @caption         = caption
        @hint            = hint
        @form_group      = form_group
        @html_attributes = kwargs

        @show_password_text = show_password_text
        @hide_password_text = hide_password_text

        @show_password_aria_label_text = show_password_aria_label_text
        @hide_password_aria_label_text = hide_password_aria_label_text

        @password_shown_announcement_text = password_shown_announcement_text
        @password_hidden_announcement_text = password_hidden_announcement_text
      end

      def html
        Containers::FormGroup.new(*bound, **form_group_options).html do
          safe_join([label_element, hint_element, error_element, password_input_and_button])
        end
      end

    private

      def password_input_and_button
        tag.div(class: wrapper_classes) do
          safe_join([password_input, button])
        end
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          spellcheck: "false",
          autocomplete: "current-password",
          autocapitalize: "none",
          aria: { describedby: combine_references(hint_id, error_id) }
        }
      end

      def form_group_options
        {
          **i18n_data,
          class: %(#{brand}-password-input),
          data: { module: %(#{brand}-password-input) },
        }.deep_merge_html_attributes(@form_group)
      end

      def password_input
        @builder.password_field(@attribute_name, attributes(@html_attributes))
      end

      def classes
        build_classes('input', 'password-input__input', 'js-password-input-input', %(password-input--error) => has_errors?).prefix(brand)
      end

      def wrapper_classes
        %w(input__wrapper password-input__wrapper).prefix(brand)
      end

      def button
        tag.button(@show_password_text, **button_options)
      end

      def button_options
        {
          data: { module: %(#{brand}-button) },
          aria: { label: "Show password", controls: field_id(link_errors: true) },
          type: 'button',
          hidden: true,
          class: %w(button button--secondary password-input__toggle js-password-input-toggle).prefix(brand)
        }
      end

      def i18n_data
        attrs = [
          I18nAttr.new("data-i18n.show-password",                @show_password_text,                :default_show_password_text),
          I18nAttr.new("data-i18n.hide-password",                @hide_password_text,                :default_hide_password_text),
          I18nAttr.new("data-i18n.show-password-aria-label",     @show_password_aria_label_text,     :default_show_password_aria_label_text),
          I18nAttr.new("data-i18n.hide-password-aria-label",     @hide_password_aria_label_text,     :default_hide_password_aria_label_text),
          I18nAttr.new("data-i18n.password-shown-announcement",  @password_shown_announcement_text,  :default_password_shown_announcement_text),
          I18nAttr.new("data-i18n.password-hidden-announcement", @password_hidden_announcement_text, :default_password_hidden_announcement_text),
        ]

        build_data_attr_hash(attrs)
      end
    end
  end
end
