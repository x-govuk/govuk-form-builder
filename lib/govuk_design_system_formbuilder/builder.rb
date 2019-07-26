module GOVUKDesignSystemFormBuilder
  module Builder
    # Generates a input of type +text+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
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
    def govuk_text_field(attribute_name, hint_text: nil, label: {}, width: 'full', **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :text, hint_text: hint_text, label: label, width: width, **args).html
    end

    # Generates a input of type +tel+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
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
    def govuk_phone_field(attribute_name, hint_text: nil, label: {}, width: 'full', **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :phone, hint_text: hint_text, label: label, width: width, **args).html
    end

    # Generates a input of type +email+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/email-addresses/ GOV.UK Email address patterns
    #
    # @example An email address field with a placeholder
    #   = f.govuk_email_field :email_address,
    #     label: { text: 'Enter your email address' },
    #     placeholder: 'ralph.wiggum@springfield.edu'
    def govuk_email_field(attribute_name, hint_text: nil, label: {}, width: 'full', **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :email, hint_text: hint_text, label: label, width: width, **args).html
    end

    # Generates a input of type +url+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    #
    # @example A url field with autocomplete
    #   = f.govuk_url_field :favourite_website,
    #     label: { text: 'Enter your favourite website' },
    #     placeholder: 'https://www.gov.uk',
    #     autocomplete: 'url'
    def govuk_url_field(attribute_name, hint_text: nil, label: {}, width: 'full', **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :url, hint_text: hint_text, label: label, width: width, **args).html
    end

    # Generates a input of type +number+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
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
    def govuk_number_field(attribute_name, hint_text: nil, label: {}, width: 'full', **args)
      Elements::Input.new(self, object_name, attribute_name, attribute_type: :number, hint_text: hint_text, label: label, width: width, **args).html
    end

    # Generates a +textarea+ element with a label, optional hint. Also offers
    # the ability to add the GOV.UK character and word counting components
    # automatically
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param [Hash] label configures the associated label
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @param max_words [Integer] adds the GOV.UK max word count
    # @param max_chars [Integer] adds the GOV.UK max characters count
    # @param threshold [Integer] only show the +max_words+ and +max_chars+ warnings once a threshold (percentage) is reached
    # @param rows [Integer] sets the initial number of rows
    # @option args [Hash] args additional arguments are applied as attributes to the +textarea+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/character-count GOV.UK character count component
    # @note Setting +max_chars+ or +max_words+ will add a caption beneath the +textarea+ with a live count of words
    #   or characters
    #
    # @example A text area with a custom number of rows and a word limit
    #   = f.govuk_number_field :cv,
    #     label: { text: 'Tell us about your work history' },
    #     rows: 8,
    #     max_words: 300
    def govuk_text_area(attribute_name, hint_text: nil, label: {}, max_words: nil, max_chars: nil, rows: 5, threshold: nil, **args)
      Elements::TextArea.new(self, object_name, attribute_name, hint_text: hint_text, label: label, max_words: max_words, max_chars: max_chars, rows: rows, threshold: threshold, **args).html
    end

    # Generates a +select+ element containing +option+ for each member in the provided collection
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the text
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @return [ActiveSupport::SafeBuffer] HTML output
    def govuk_collection_select(attribute_name, collection, value_method, text_method, options: {}, html_options: {}, hint_text: nil, label: {}, &block)
      Elements::Select.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method: value_method,
        text_method: text_method,
        hint_text: hint_text,
        label: label,
        options: options,
        html_options: html_options,
        &block
      ).html
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
    # @param legend [Hash] options for configuring the legend
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @param small [Boolean] controls whether small radio buttons are used instead of regular-sized ones
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+, defaults to +h1+
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
    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method, hint_method = nil, hint_text: nil, legend: { text: nil, size: 'm' }, inline: false, small: false, &block)
      Elements::Radios::Collection.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method: value_method,
        text_method: text_method,
        hint_method: hint_method,
        hint_text: hint_text,
        legend: legend,
        inline: inline,
        small: small,
        &block
      ).html
    end

    # Generates a radio button fieldset container and injects the supplied block contents
    #
    # @note The intention is to use {#govuk_radio_button} and {#govuk_radio_divider} within the passed-in block
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param legend [Hash] options for configuring the legend
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @param small [Boolean] controls whether small radio buttons are used instead of regular-sized ones
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @param block [Block] a block of HTML that will be used to populate the fieldset
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
    def govuk_radio_buttons_fieldset(attribute_name, hint_text: nil, legend: {}, inline: false, small: false, &block)
      Containers::RadioButtonsFieldset.new(self, object_name, attribute_name, hint_text: hint_text, legend: legend, inline: inline, small: small, &block).html
    end

    # Generates a radio button
    #
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] the contents of the hint
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @see https://design-system.service.gov.uk/components/radios/ GOV.UK Radios
    # @param block [Block] Any supplied HTML will be wrapped in a conditional
    #   container and only revealed when the radio button is picked
    # @param link_errors [Boolean] controls whether this radio button should be linked to
    #   from the error summary. <b>Should only be set to +true+ for the first radio button in a fieldset</b>
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of radio buttons for favourite colours with a divider
    #
    #  = f.govuk_collection_radio_buttons :favourite_colour, inline: false do
    #    = f.govuk_radio_button :favourite_colour, :red, label: { text: 'Red' } do
    #
    def govuk_radio_button(attribute_name, value, hint_text: nil, label: {}, link_errors: false, &block)
      Elements::Radios::FieldsetRadioButton.new(self, object_name, attribute_name, value, hint_text: hint_text, label: label, link_errors: link_errors, &block).html
    end

    # Inserts a text divider into a list of radio buttons
    #
    # @param text [String] The divider text
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @see https://design-system.service.gov.uk/components/radios/#radio-items-with-a-text-divider GOV.UK Radios with a text divider
    # @return [ActiveSupport::SafeBuffer] HTML output
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
    # @param small [Boolean] controls whether small check boxes are used instead of regular-sized ones
    # @param legend [Hash] options for configuring the legend
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
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
    def govuk_collection_check_boxes(attribute_name, collection, value_method, text_method, hint_method = nil, hint_text: nil, legend: {}, small: false, &block)
      Elements::CheckBoxes::Collection.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method: value_method,
        text_method: text_method,
        hint_method: hint_method,
        hint_text: hint_text,
        legend: legend,
        small: small,
        &block
      ).html
    end

    # Generate a fieldset intended to conatain one or more {#govuk_check_box}
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param small [Boolean] controls whether small check boxes are used instead of regular-sized ones
    # @param legend [Hash] options for configuring the legend
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @param block [Block] a block of HTML that will be used to populate the fieldset
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of check boxes for sandwich fillings
    #
    #  = f.govuk_check_boxes_fieldset :desired_filling,
    #    = f.govuk_check_box :desired_filling, :cheese, label: { text: 'Cheese' }, link_errors: true
    #    = f.govuk_check_box :desired_filling, :tomato, label: { text: 'Tomato' }
    #
    def govuk_check_boxes_fieldset(attribute_name, legend: {}, hint_text: {}, small: false, &block)
      Containers::CheckBoxesFieldset.new(
        self,
        object_name,
        attribute_name,
        hint_text: hint_text,
        legend: legend,
        small: small,
        &block
      ).html
    end

    # Generates a single fieldset, intended for use within a {#govuk_check_boxes_fieldset}
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param value [Boolean,String,Symbol,Integer] The value of the checkbox when it is checked
    # @param hint_text [String] the contents of the hint
    # @param link_errors [Boolean] controls whether this radio button should be linked to
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @param multiple [Boolean] controls whether the check box is part of a collection or represents a single attribute
    # @param block [Block] any HTML passed in will form the contents of the fieldset
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A single check box for terms and conditions
    #   = f.govuk_check_box :terms_agreed,
    #     true,
    #     multiple: false,
    #     link_errors: true,
    #     label: { text: 'Do you agree with our terms and conditions?' },
    #     hint_text: 'You will not be able to proceed unless you do'
    #
    def govuk_check_box(attribute_name, value, hint_text: nil, label: {}, link_errors: false, multiple: true, &block)
      Elements::CheckBoxes::FieldsetCheckBox.new(
        self,
        object_name,
        attribute_name,
        value,
        hint_text: hint_text,
        label: label,
        link_errors: link_errors,
        multiple: multiple,
        &block
      ).html
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
    # @param validate [Boolean] adds the formnovalidate to the submit button when true, this disables all
    #   client-side validation provided by the browser. This is to provide a more consistent and accessible user
    #   experience
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
    def govuk_submit(text = 'Continue', warning: false, secondary: false, prevent_double_click: true, validate: false, &block)
      Elements::Submit.new(self, text, warning: warning, secondary: secondary, prevent_double_click: prevent_double_click, validate: validate, &block).html
    end

    # Generates three inputs for the +day+, +month+ and +year+ components of a date
    #
    # @note When using this input be aware that Rails's multiparam time and date handling falls foul
    #   of {https://bugs.ruby-lang.org/issues/5988 this} bug, so incorrect dates like +2019-09-31+ will
    #   be 'rounded' up to +2019-10-01+.
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] the contents of the hint
    # @param legend [Hash] options for configuring the legend
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input group
    # @param date_of_birth [Boolean] if +true+ {https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete#Values birth date auto completion attributes}
    #   will be added to the inputs
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @see https://github.com/alphagov/govuk-frontend/issues/1449 GOV.UK date input element attributes, using text instead of number
    #
    # @example A regular date input with a legend and hint
    #   = f.govuk_date_field :starts_on,
    #     legend: { 'When does your event start?' },
    #     hint_text: 'Leave this field blank if you don't know exactly' }
    def govuk_date_field(attribute_name, hint_text: nil, legend: {}, date_of_birth: false, &block)
      Elements::Date.new(self, object_name, attribute_name, hint_text: hint_text, legend: legend, date_of_birth: date_of_birth, &block).html
    end

    # Generates a summary of errors in the form, each linking to the corresponding
    # part of the form that contains the error
    #
    # @param title [String] the error summary heading
    #
    # @todo Currently the summary anchors link to the inline error messages themselves rather to
    #   the accompanying input. More work is required to improve this and it needs to be
    #   handled in a less-generic manner. For example, we can't link to a specific radio button
    #   if one hasn't been chosen but we should link to a {#govuk_text_field} if one has been left
    #   blank
    #
    # @example An error summary with a custom title
    #   = f.govuk_error_summary 'Uh-oh, spaghettios'
    #
    # @see https://design-system.service.gov.uk/components/error-summary/ GOV.UK error summary
    def govuk_error_summary(title = 'There is a problem')
      Elements::ErrorSummary.new(self, object_name, title).html
    end

    # Generates a fieldset containing the contents of the block
    #
    # @param legend [Hash] options for configuring the legend
    # @param described_by [Array<String>] the ids of the elements that describe this fieldset, usually hints and errors
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    #
    # @example A fieldset containing address fields
    #   = f.govuk_fieldset legend: { text: 'Address' }
    #     = f.govuk_text_field :street
    #     = f.govuk_text_field :town
    #     = f.govuk_text_field :city
    #
    # @see https://design-system.service.gov.uk/components/fieldset/ GOV.UK fieldset
    # @return [ActiveSupport::SafeBuffer] HTML output
    def govuk_fieldset(legend: { text: 'Fieldset heading' }, described_by: nil, &block)
      Containers::Fieldset.new(self, legend: legend, described_by: described_by).html(&block)
    end

    # Generates an input of type +file+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @option label text [String] the label text
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @option args [Hash] args additional arguments are applied as attributes to +input+ element
    #
    # @example A photo upload field with file type specifier
    #   = f.govuk_file_field :photo, label: { text: 'Upload your photo' }, accept: 'image/*'
    #
    # @see https://design-system.service.gov.uk/components/file-upload/ GOV.UK file upload
    # @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file MDN documentation for file upload
    #
    # @note Remember to set +multipart: true+ when creating a form with file
    #   uploads, {https://guides.rubyonrails.org/form_helpers.html#uploading-files see
    #   the Rails documentation} for more information
    def govuk_file_field(attribute_name, label: {}, hint_text: nil, **args)
      Elements::File.new(self, object_name, attribute_name, label: label, hint_text: hint_text, **args).html
    end
  end
end
