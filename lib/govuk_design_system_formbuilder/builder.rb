module GOVUKDesignSystemFormBuilder
  module Builder
    def govuk_text_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, 'text', hint: hint, label: label, **args)
    end

    def govuk_tel_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, 'tel', hint: hint, label: label, **args)
    end

    def govuk_email_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, 'email', hint: hint, label: label, **args)
    end

    def govuk_url_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, 'url', hint: hint, label: label, **args)
    end

    def govuk_number_field(attribute_name, hint: {}, label: {}, **args)
      govuk_generic_text_field(attribute_name, 'number', hint: hint, label: label, **args)
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

    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method, hint_method = nil, options: {}, html_options: {}, hint: {}, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          hint_element.html,
          Containers::Fieldset.new(self, object_name, attribute_name, legend: legend).html do
            safe_join(
              [
                (yield if block_given?),
                content_tag('div', class: 'govuk-radios', data: { module: "radios" }) do
                  safe_join(
                    collection.map do |item|
                      Elements::Radio.new(self, object_name, attribute_name, item, value_method, text_method, hint_method).html
                    end
                  )
                end
              ].compact
            )
          end
        ])
      end
    end

  private

    def govuk_generic_text_field(attribute_name, field_type, label: nil, hint: nil, width: nil, **args)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint)
      label_element = Elements::Label.new(self, object_name, attribute_name, label)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      input_element = Elements::Input.new(
        self,
        object_name,
        attribute_name,
        width: width,
        **args.merge(
          type: field_type,
          aria: {
            describedby: classes_to_str([hint_element.hint_id, error_element.error_id])
          }
        )
      )

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
