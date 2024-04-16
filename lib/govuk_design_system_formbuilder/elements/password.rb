module GOVUKDesignSystemFormBuilder
  module Elements
    class Password < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::HTMLAttributes
      include Traits::HTMLClasses

      I18nAttr = Struct.new(:key, :text, :default)

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
          **@form_group,
          **i18n_data,
          class: %(#{brand}-password-input),
          data: { module: %(#{brand}-password-input) },
        }
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
        [
          I18nAttr.new("data-i18n.show-password",                @show_password_text,                config.default_show_password_text),
          I18nAttr.new("data-i18n.hide-password",                @hide_password_text,                config.default_hide_password_text),
          I18nAttr.new("data-i18n.show-password-aria-label",     @show_password_aria_label_text,     config.default_show_password_aria_label_text),
          I18nAttr.new("data-i18n.hide-password-aria-label",     @hide_password_aria_label_text,     config.default_hide_password_aria_label_text),
          I18nAttr.new("data-i18n.password-shown-announcement",  @password_shown_announcement_text,  config.default_password_shown_announcement_text),
          I18nAttr.new("data-i18n.password-hidden-announcement", @password_hidden_announcement_text, config.default_password_hidden_announcement_text),
        ].each_with_object({}) do |attr, h|
          h[attr.key] = attr.text unless attr.text == attr.default
        end
      end
    end
  end
end
