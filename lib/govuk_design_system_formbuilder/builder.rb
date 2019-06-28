module GOVUKDesignSystemFormBuilder
  module Builder

    # Generates a input of type `text`
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    #
    # @example A required full name field with a placeholder
    #   = govuk_text_field :name,
    #     label: { text: 'Full name' },
    #     hint_text: 'It says it on your birth certificate',
    #     required: true,
    #     placeholder: 'Ralph Wiggum'
    def govuk_text_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :text, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type `tel`
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    #
    # @example A required phone number field with a placeholder
    #   = govuk_phone_field :phone_number,
    #     label: { text: 'UK telephone number' },
    #     hint_text: 'Include the dialling code',
    #     required: true,
    #     placeholder: '0123 456 789'
    def govuk_phone_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :phone, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type `email`
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    #
    # @example An email address field with a placeholder
    #   = govuk_email_field :email_address,
    #     label: { text: 'Enter your email address' },
    #     placeholder: 'ralph.wiggum@springfield.edu'
    def govuk_email_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :email, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type `url`
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    #
    # @example A url field with autocomplete
    #   = govuk_url_field :favourite_website,
    #     label: { text: 'Enter your favourite website' },
    #     placeholder: 'https://www.gov.uk',
    #     autocomplete: 'url'
    def govuk_url_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :url, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type `number`
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    #
    # @example A number field with placeholder, min, max and step
    #   = govuk_number_field :iq,
    #     label: { text: 'What is your IQ?' },
    #     placeholder: 100,
    #     min: 80,
    #     max: 150,
    #     step: 5
    def govuk_number_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :number, hint_text: hint_text, label: label, **args).html
    end


    # Generates a text area with label, hint offers the ability to add the GOV.UK character and word counting
    # components automatically
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @param max_words [Integer] adds the GOV.UK max word count
    # @param max_chars [Integer] adds the GOV.UK max characters count
    # @option args [Hash] args additional arguments are applied as attributes to the +textarea+ element
    # @see https://design-system.service.gov.uk/components/character-count GOV.UK character count component
    # @note Setting +max_chars+ or +max_words+ will add a caption beneath the +textarea+ with a live count of words
    #   or characters
    # @example A number field with placeholder, min, max and step
    #   = govuk_number_field :cv,
    #     label: { text: 'Tell us about your work history' },
    #     rows: 8,
    #     max_words: 300
    def govuk_text_area(attribute_name, hint_text: nil, label: {}, max_words: nil, max_chars: nil, rows: 5, **args)
      Elements::TextArea.new(self, object_name, attribute_name, hint_text: hint_text, label: label, max_words: max_words, max_chars: max_chars, rows: rows, **args).html
    end

    # FIXME #govuk_collection_select args differ from Rails' #collection_select args in that
    # options: and :html_options are keyword arguments. Leaving them as regular args with
    # defaults and following them with keyword args (hint and label) doesn't seem to work
    def govuk_collection_select(attribute_name, collection, value_method, text_method, options: {}, html_options: {}, hint_text: nil, label: {})
      label_element = Elements::Label.new(self, object_name, attribute_name, label)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
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
                describedby: [
                  hint_element.hint_id,
                  error_element.error_id
                ].compact.join(' ').presence
              }
            )
          )
        ])
      end
    end

    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method, hint_method = nil, options: { inline: false }, html_options: {}, hint_text: nil, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join(
          [
            hint_element.html,
            error_element.html,

            Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
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

    def govuk_radio_buttons_fieldset(attribute_name, options: { inline: false }, hint_text: nil, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        safe_join([
          hint_element.html,
          error_element.html,
          Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
            Containers::Radios.new(self, inline: options.dig(:inline)).html do
              yield
            end
          end
        ])
      end
    end

    # only intended for use inside a #govuk_radio_buttons_fieldset
    def govuk_radio_button(attribute_name, value, hint_text: nil, label: {}, &block)
      Elements::Radios::FieldsetRadio.new(self, object_name, attribute_name, value, hint_text: hint_text, label: label, &block).html
    end

    def govuk_radio_divider(text = 'or')
      tag.div(text, class: %w(govuk-radios__divider))
    end

    def govuk_collection_check_boxes(attribute_name, collection, value_method, text_method, hint_method = nil, html_options: {}, hint_text: nil, legend: {})
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
      Containers::FormGroup.new(self, object_name, attribute_name).html do
        Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: hint_element.hint_id).html do
          safe_join(
            [
              hint_element.html,
              (yield if block_given?),
              collection_check_boxes(attribute_name, collection, value_method, text_method) do |check_box|
                Elements::CheckBoxes::CollectionCheckBox.new(self, attribute_name, check_box, hint_method).html
              end
            ]
          )
        end
      end
    end

    def govuk_submit(text = 'Continue', warning: false, secondary: false, prevent_double_click: true, &block)
      Elements::Submit.new(self, text, warning: warning, secondary: secondary, prevent_double_click: prevent_double_click, &block).html
    end

    def govuk_date_field(attribute_name, hint_text: nil, legend: {}, date_of_birth: false, &block)
      Elements::Date.new(self, object_name, attribute_name, hint_text: hint_text, legend: legend, date_of_birth: date_of_birth, &block).html
    end
  end
end
