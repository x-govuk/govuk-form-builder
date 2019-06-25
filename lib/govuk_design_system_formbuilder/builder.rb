module GOVUKDesignSystemFormBuilder
  module Builder
    def govuk_text_field(attribute_name, hint: {}, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :text, hint: hint, label: label, **args).html
    end

    def govuk_phone_field(attribute_name, hint: {}, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :phone, hint: hint, label: label, **args).html
    end

    def govuk_email_field(attribute_name, hint: {}, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :email, hint: hint, label: label, **args).html
    end

    def govuk_url_field(attribute_name, hint: {}, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :url, hint: hint, label: label, **args).html
    end

    def govuk_number_field(attribute_name, hint: {}, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :number, hint: hint, label: label, **args).html
    end

    def govuk_text_area(attribute_name, hint: {}, label: {}, max_words: nil, max_chars: nil, rows: 5, **args)
      Elements::TextArea.new(self, object_name, attribute_name, hint: hint, label: label, max_words: max_words, max_chars: max_chars, rows: rows, **args).html
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
                        Elements::Radios::CollectionRadio.new(self, object_name, attribute_name, item, value_method, text_method, hint_method).html
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

    def govuk_radio_buttons_fieldset(attribute_name, options: { inline: false }, hint: {}, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          hint_element.html,
          Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: hint_element.hint_id).html do
            Containers::Radios.new(self, inline: options.dig(:inline)).html do
              yield
            end
          end
        ])
      end
    end

    # only intended for use inside a #govuk_radio_buttons_fieldset
    def govuk_radio_button(attribute_name, value, hint: {}, label: {})
      Elements::Radios::FieldsetRadio.new(self, object_name, attribute_name, value, hint: hint, label: label).html do
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
              collection_check_boxes(attribute_name, collection, value_method, text_method) do |check_box|
                Elements::CheckBoxes::CollectionCheckBox.new(self, attribute_name, check_box, hint_method).html
              end
            end
          ]
        )
      end
    end

    def govuk_check_boxes_fieldset(attribute_name, html_options: {}, hint: {}, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          hint_element.html,
          Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: hint_element.hint_id).html do
            Containers::CheckBoxes.new(self).html do
              yield
            end
          end
        ])
      end
    end

    def govuk_check_box(attribute_name, value, hint: {}, label: {})
      Elements::CheckBox.new(self, object_name, attribute_name, value, hint: hint, label: label).html do
        (yield if block_given?)
      end
    end

    def govuk_submit(text = 'Continue', warning: false, secondary: false, prevent_double_click: true)
      Elements::Submit.new(self, text, warning: warning, secondary: secondary, prevent_double_click: prevent_double_click).html do
        (yield if block_given?)
      end
    end

    def govuk_date_field(attribute_name, hint: {}, legend: {})
      Elements::Date.new(self, object_name, attribute_name, hint: hint, legend: legend).html do
        (yield if block_given?)
      end
    end

  private

    # TODO this is duplicated in Base, remove from here
    def classes_to_str(classes)
      if classes.any? && str = classes.compact.join(' ')
        str
      else
        nil
      end
    end
  end
end
