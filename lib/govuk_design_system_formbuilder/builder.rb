module GOVUKDesignSystemFormBuilder
  module Builder
    def govuk_text_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, :text_field, hint: hint, label: label, **args)
    end

    def govuk_phone_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, :phone_field, hint: hint, label: label, **args)
    end

    def govuk_email_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, :email_field, hint: hint, label: label, **args)
    end

    def govuk_url_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, :url_field, hint: hint, label: label, **args)
    end

    def govuk_number_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, :number_field, hint: hint, label: label, **args)
    end

    # FIXME #govuk_collection_select args differ from Rails' #collection_select args in that
    # options: and :html_options are keyword arguments. Leaving them as regular args with
    # defaults and following them with keyword args (hint and label) doesn't seem to work
    def govuk_collection_select(attribute_name, collection, value_method, text_method, options: {}, html_options: {}, hint: {}, label: {})
      label_element = Elements::Label.new(self, object_name, attribute_name, label)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          label_element.html,
          hint_element.html,
          error_element.html,

          (yield if block_given?),

          collection_select(
            attribute_name,
            collection,
            value_method,
            text_method,
            options,
            html_options.merge(
              aria: {
                describedby: classes_to_str([hint_element.hint_id, error_element.error_id])
              }
            )
          )
        ])
      end
    end

    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method, hint_method = nil, options: { inline: false }, html_options: {}, hint: {}, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join(
          [
            hint_element.html,
            Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: hint_element.hint_id).html do
              safe_join(
                [
                  (yield if block_given?),
                  Containers::Radios.new(self, inline: options.dig(:inline)).html do
                    safe_join(
                      collection.map do |item|
                        Elements::RadioButton::CollectionRadio.new(self, object_name, attribute_name, item, value_method, text_method, hint_method).html
                      end
                    )
                  end
                ].compact
              )
            end
          ]
        )
      end
    end

    def govuk_radio_buttons_fieldset(attribute_name, options: { inline: false }, html_options: {}, hint: {}, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          hint_element.html,
          Containers::Radios.new(self, inline: options.dig(:inline)).html do
            Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: hint_element.hint_id).html do
              yield
            end
          end
        ])
      end
    end

    # only intended for use inside a #govuk_radio_buttons_fieldset
    def govuk_radio_button(attribute_name, value, hint: {}, label: {})
      Elements::RadioButton::FieldsetRadio.new(self, object_name, attribute_name, value, hint: hint, label: label).html do
        (yield if block_given?)
      end
    end

    def govuk_collection_check_boxes(attribute_name, collection, value_method, text_method, hint_method = nil, html_options: {}, hint: {}, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join(
          [
            hint_element.html,
            (yield if block_given?),
            Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: hint_element.hint_id).html do
              collection_check_boxes(attribute_name, collection, value_method, text_method) do |cb|
                Elements::CheckBox::CollectionCheckBox.new(self, cb, value_method, text_method, hint_method).html
              end
            end
          ]
        )
      end
    end

  private

    def govuk_generic_text_field(attribute_name, builder_method, label: nil, hint: nil, width: nil, **args)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      label_element = Elements::Label.new(self, object_name, attribute_name, label)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)
      input_element = Elements::Input.new(self, object_name, attribute_name, width: width, **args.merge(
        builder_method: builder_method,
        aria: { describedby: classes_to_str([hint_element.hint_id, error_element.error_id]) }
      ))

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([label_element, hint_element, error_element, input_element].map(&:html))
      end
    end

    def classes_to_str(classes)
      if classes.any? && str = classes.compact.join(' ')
        str
      else
        nil
      end
    end
  end
end
