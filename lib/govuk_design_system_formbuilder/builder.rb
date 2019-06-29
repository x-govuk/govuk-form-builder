module GOVUKDesignSystemFormBuilder
  module Builder
    # Generates a input of type +text+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    #
    # @example A required full name field with a placeholder
    #   = f.govuk_text_field :name,
    #     label: { text: 'Full name' },
    #     hint_text: 'It says it on your birth certificate',
    #     required: true,
    #     placeholder: 'Ralph Wiggum'
    def govuk_text_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :text, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type +tel+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/telephone-numbers/ GOV.UK Telephone number patterns
    #
    # @example A required phone number field with a placeholder
    #   = f.govuk_phone_field :phone_number,
    #     label: { text: 'UK telephone number' },
    #     hint_text: 'Include the dialling code',
    #     required: true,
    #     placeholder: '0123 456 789'
    def govuk_phone_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :phone, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type +email+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/email-addresses/ GOV.UK Email address patterns
    #
    # @example An email address field with a placeholder
    #   = f.govuk_email_field :email_address,
    #     label: { text: 'Enter your email address' },
    #     placeholder: 'ralph.wiggum@springfield.edu'
    def govuk_email_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :email, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type +url+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    #
    # @example A url field with autocomplete
    #   = f.govuk_url_field :favourite_website,
    #     label: { text: 'Enter your favourite website' },
    #     placeholder: 'https://www.gov.uk',
    #     autocomplete: 'url'
    def govuk_url_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :url, hint_text: hint_text, label: label, **args).html
    end

    # Generates a input of type +number+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    #
    # @example A number field with placeholder, min, max and step
    #   = f.govuk_number_field :iq,
    #     label: { text: 'What is your IQ?' },
    #     placeholder: 100,
    #     min: 80,
    #     max: 150,
    #     step: 5
    def govuk_number_field(attribute_name, hint_text: nil, label: {}, **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :number, hint_text: hint_text, label: label, **args).html
    end


    # Generates a +textarea+ element with a label, optional hint. Also offers
    # the ability to add the GOV.UK character and word counting components
    # automatically
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @param max_words [Integer] adds the GOV.UK max word count
    # @param max_chars [Integer] adds the GOV.UK max characters count
    # @option args [Hash] args additional arguments are applied as attributes to the +textarea+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/character-count GOV.UK character count component
    # @note Setting +max_chars+ or +max_words+ will add a caption beneath the +textarea+ with a live count of words
    #   or characters
    #
    # @example A number field with placeholder, min, max and step
    #   = f.govuk_number_field :cv,
    #     label: { text: 'Tell us about your work history' },
    #     rows: 8,
    #     max_words: 300
    def govuk_text_area(attribute_name, hint_text: nil, label: {}, max_words: nil, max_chars: nil, rows: 5, **args)
      Elements::TextArea.new(self, object_name, attribute_name, hint_text: hint_text, label: label, max_words: max_words, max_chars: max_chars, rows: rows, **args).html
    end

    # Generates a +select+ element containing +option+ for each member in the provided collection
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the text
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +large+, +medium+, +regular+ or +small+
    # @option label weight [String] the weight of the label font, can be +bold+ or +regular+
    # @return [ActiveSupport::SafeBuffer] HTML output
    def govuk_collection_select(attribute_name, collection, value_method, text_method, options: {}, html_options: {}, hint_text: nil, label: {}, &block)
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

    # Generates a radio button for each item in the supplied collection
    #
    # @note Unlike the Rails +collection_radio_buttons+ helper, this version can also insert
    #   hints per item in the collection by supplying a +:hint_method+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the text
    # @param hint_method [Symbol] The method called against each member of the collection to provide the hint text
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param legend [Hash] options for configuring the hash
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @param block [Block] any HTML passed in is inserted inside the fieldset container,
    #   between the error and the radios container element
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of radio buttons for favourite colours
    #
    #  @colours = [
    #    OpenStruct.new(id: 'red', name: 'Red', description: 'Roses are red'),
    #    OpenStruct.new(id: 'blue', name: 'Blue', description: 'Violets are... purple?')
    #  ]
    #
    #  = f.govuk_collection_radio_buttons :favourite_colour,
    #    @colours,
    #    :id,
    #    :name,
    #    :description,
    #    legend: { text: 'Pick your favourite colour', size: 'm' },
    #    hint_text: 'If you cannot find the exact match choose something close',
    #    inline: false
    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method, hint_method = nil, hint_text: nil, legend: { text: nil, size: 'm' }, inline: false, &block)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
          safe_join(
            [
              hint_element.html,
              error_element.html,

              (yield if block_given?),
              Containers::Radios.new(self, inline: inline).html do
                safe_join(
                  collection.map do |item|
                    Elements::Radios::CollectionRadio.new(self, object_name, attribute_name, item, value_method, text_method, hint_method).html
                  end
                )
              end
            ].compact
          )
        end
      end
    end

    # Generates a radio button fieldset container and injects the supplied block contents
    #
    # @note The intention is to use {#govuk_radio_button} and {#govuk_radio_divider} within the passed-in block
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param legend [Hash] options for configuring the hash
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @param block [Block] any HTML passed in will be injected into the fieldset
    #   element and should contain radio buttons and optionally a divider
    # @see https://design-system.service.gov.uk/components/radios/ GOV.UK Radios
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of radio buttons for favourite colours with a divider
    #
    #  = f.govuk_collection_radio_buttons :favourite_colour, inline: false do
    #    = f.govuk_radio_button :favourite_colour, :red, label: { text: 'Red' }
    #    = f.govuk_radio_button :favourite_colour, :green, label: { text: 'Green' }
    #    = f.govuk_radio_divider
    #    = f.govuk_radio_button :favourite_colour, :yellow, label: { text: 'Yellow' }
    #
    def govuk_radio_buttons_fieldset(attribute_name, inline: false, hint_text: nil, legend: {}, &block)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
          safe_join([
            hint_element.html,
            error_element.html,
            Containers::Radios.new(self, inline: inline).html do
              yield
            end
          ])
        end
      end
    end


    # Generates a radio button
    #
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] the contents of the hint
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @see https://design-system.service.gov.uk/components/radios/ GOV.UK Radios
    # @param block [Block] Any supplied HTML will be wrapped in a conditional
    #   container and only revealed when the radio button is picked
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of radio buttons for favourite colours with a divider
    #
    #  = f.govuk_collection_radio_buttons :favourite_colour, inline: false do
    #    = f.govuk_radio_button :favourite_colour, :red, label: { text: 'Red' } do
    #
    def govuk_radio_button(attribute_name, value, hint_text: nil, label: {}, &block)
      Elements::Radios::FieldsetRadio.new(self, object_name, attribute_name, value, hint_text: hint_text, label: label, &block).html
    end

    # Inserts a text divider into a list of radio buttons
    #
    # @param text [String] The divider text
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @see https://design-system.service.gov.uk/components/radios/#radio-items-with-a-text-divider GOV.UK Radios with a text divider
    # @example A custom divider
    #   = govuk_radio_divider 'Alternatively'
    def govuk_radio_divider(text = 'or')
      tag.div(text, class: %w(govuk-radios__divider))
    end

    # Generate a list of check boxes from a collection
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the text
    # @param hint_method [Symbol] The method called against each member of the collection to provide the hint text
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param legend [Hash] options for configuring the hash
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @param block [Block] any HTML passed in will be injected into the fieldset, after the hint and before the checkboxes
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of check boxes for sandwich fillings
    #
    #  @fillings = [
    #    OpenStruct.new(id: 'pastrami', name: 'Pastrami', description: 'Brined, smoked, steamed and seasoned'),
    #    OpenStruct.new(id: 'cheddar', name: 'Cheddar', description: 'A sharp, off-white natural cheese')
    #  ]
    #
    #  = f.govuk_collection_check_boxes :desired_filling,
    #    @fillings,
    #    :id,
    #    :name,
    #    :description,
    #    legend: { text: 'What do you want in your sandwich?', size: 'm' },
    #    hint_text: "If it isn't listed here, tough luck",
    #    inline: false
    def govuk_collection_check_boxes(attribute_name, collection, value_method, text_method, hint_method = nil, hint_text: nil, legend: {}, &block)
      hint_element  = Elements::Hint.new(self, object_name, attribute_name, hint_text)
      error_element = Elements::ErrorMessage.new(self, object_name, attribute_name)

      Containers::FormGroup.new(self, object_name, attribute_name).html do
        Containers::Fieldset.new(self, object_name, attribute_name, legend: legend, described_by: [error_element.error_id, hint_element.hint_id]).html do
          safe_join(
            [
              hint_element.html,
              error_element.html,
              (block.call if block_given?),
              collection_check_boxes(attribute_name, collection, value_method, text_method) do |check_box|
                Elements::CheckBoxes::CollectionCheckBox.new(self, attribute_name, check_box, hint_method).html
              end
            ]
          )
        end
      end
    end

    # Generates a submit button, green by default
    #
    # @param text [String] the button text
    # @param warning [Boolean] makes the button red ({https://design-system.service.gov.uk/components/button/#warning-buttons warning}) when true
    # @param secondary [Boolean] makes the button grey ({https://design-system.service.gov.uk/components/button/#secondary-buttons secondary}) when true
    # @todo The GOV.UK design system also supports {https://design-system.service.gov.uk/components/button/#disabled-buttons disabled buttons}, they
    #   should probably be supported too
    # @param prevent_double_click [Boolean] adds JavaScript to safeguard the
    #   form from being submitted more than once
    # @param block [Block] Any supplied HTML will be inserted immediately after
    #   the submit button. It is intended for other buttons directly related to
    #   the form's operation, such as 'Cancel' or 'Safe draft'
    # @raise [ArgumentError] raised if both +warning+ and +secondary+ are true
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @note Only the first additional button or link (passed in via a block) will be given the
    #   correct left margin, subsequent buttons will need to be manually accounted for
    # @see https://design-system.service.gov.uk/components/button/#stop-users-from-accidentally-sending-information-more-than-once
    #   GOV.UK double click prevention
    #
    # @example A submit button with custom text, double click protection and an inline cancel link
    #   = f.govuk_submit "Proceed", prevent_double_click: true do
    #     = link_to 'Cancel', some_other_path, class: 'govuk-button__secondary'
    #
    def govuk_submit(text = 'Continue', warning: false, secondary: false, prevent_double_click: true, &block)
      Elements::Submit.new(self, text, warning: warning, secondary: secondary, prevent_double_click: prevent_double_click, &block).html
    end

    # Generates three number inputs for the +day+, +month+ and +year+ components of a date
    #
    # @note When using this input be aware that Rails's multiparam time and date handling falls foul
    #   of {https://bugs.ruby-lang.org/issues/5988 this} bug, so incorrect dates like +2019-09-31+ will
    #   be 'rounded' up to +2019-10-01+.
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] the contents of the hint
    # @param legend [Hash] options for configuring the hash
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input group
    # @param date_of_birth [Boolean] if +true+ {https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete#Values birth date auto completion attributes}
    #   will be added to the inputs
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A regular date input with a legend and hint
    #   = f.govuk_date_field :starts_on,
    #     legend: { 'When does your event start?' },
    #     hint_text: 'Leave this field blank if you don't know exactly' }
    def govuk_date_field(attribute_name, hint_text: nil, legend: {}, date_of_birth: false, &block)
      Elements::Date.new(self, object_name, attribute_name, hint_text: hint_text, legend: legend, date_of_birth: date_of_birth, &block).html
    end
  end
end
