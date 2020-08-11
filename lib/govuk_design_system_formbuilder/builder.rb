module GOVUKDesignSystemFormBuilder
  module Builder
    delegate :config, to: GOVUKDesignSystemFormBuilder

    # Generates a input of type +text+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A required full name field with a placeholder
    #   = f.govuk_text_field :name,
    #     label: { text: 'Full name' },
    #     hint_text: 'It says it on your birth certificate',
    #     required: true,
    #     placeholder: 'Ralph Wiggum'
    #
    # @example A text field with injected content
    #   = f.govuk_text_field :pseudonym,
    #     label: { text: 'Pseudonym' } do
    #
    #     p.govuk-inset-text
    #       | Ensure your stage name is unique
    #
    # @example A text field with the label supplied as a proc
    #   = f.govuk_text_field :callsign,
    #     label: -> { tag.h3('Call-sign') }
    #
    def govuk_text_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, form_group: {}, **args, &block)
      Elements::Inputs::Text.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, width: width, form_group: form_group, **args, &block).html
    end

    # Generates a input of type +tel+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/telephone-numbers/ GOV.UK Telephone number patterns
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A required phone number field with a placeholder
    #   = f.govuk_phone_field :phone_number,
    #     label: { text: 'UK telephone number' },
    #     hint_text: 'Include the dialling code',
    #     required: true,
    #     placeholder: '0123 456 789'
    #
    # @example A phone field with injected content
    #   = f.govuk_phone_field :fax_number,
    #     label: { text: 'Fax number' } do
    #
    #     p.govuk-inset-text
    #       | Yes, fax machines are still a thing
    #
    # @example A phone field with the label supplied as a proc
    #   = f.govuk_phone_field :work_number,
    #     label: -> { tag.h3('Work number') }
    #
    def govuk_phone_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, form_group: {}, **args, &block)
      Elements::Inputs::Phone.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, width: width, form_group: form_group, **args, &block).html
    end

    # Generates a input of type +email+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/email-addresses/ GOV.UK Email address patterns
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example An email address field with a placeholder
    #   = f.govuk_email_field :email_address,
    #     label: { text: 'Enter your email address' },
    #     placeholder: 'ralph.wiggum@springfield.edu'
    #
    # @example An email field with injected content
    #   = f.govuk_phone_field :work_email,
    #     label: { text: 'Work email address' } do
    #
    #     p.govuk-inset-text
    #       | Use your work address
    #
    # @example A email field with the label supplied as a proc
    #   = f.govuk_email_field :personal_email,
    #     label: -> { tag.h3('Personal email address') }
    #
    def govuk_email_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, form_group: {}, **args, &block)
      Elements::Inputs::Email.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, width: width, form_group: form_group, **args, &block).html
    end

    # Generates a input of type +password+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/passwords/ GOV.UK Password patterns
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A password field
    #   = f.govuk_password_field :password,
    #     label: { text: 'Enter your password' }
    #
    # @example A password field with injected content
    #   = f.govuk_password_field :password,
    #     label: { text: 'Password' } do
    #
    #     p.govuk-inset-text
    #       | Ensure your password is at least 16 characters long
    #
    # @example A password field with the label supplied as a proc
    #   = f.govuk_password_field :passcode,
    #     label: -> { tag.h3('What is your secret pass code?') }
    #
    def govuk_password_field(attribute_name, hint: {}, label: {}, width: nil, form_group: {}, caption: {}, **args, &block)
      Elements::Inputs::Password.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, width: width, form_group: form_group, **args, &block).html
    end

    # Generates a input of type +url+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A url field with autocomplete
    #   = f.govuk_url_field :favourite_website,
    #     label: { text: 'Enter your favourite website' },
    #     placeholder: 'https://www.gov.uk',
    #     autocomplete: 'url'
    #
    # @example A url field with injected content
    #   = f.govuk_url_field :personal_website,
    #     label: { text: 'Enter your website' } do
    #
    #       p.govuk-inset-text
    #         | This will be visible on your profile
    #
    # @example A url field with the label supplied as a proc
    #   = f.govuk_url_field :work_website,
    #     label: -> { tag.h3("Enter your company's website") }
    #
    def govuk_url_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, form_group: {}, **args, &block)
      Elements::Inputs::URL.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, width: width, form_group: form_group, **args, &block).html
    end

    # Generates a input of type +number+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A number field with placeholder, min, max and step
    #   = f.govuk_number_field :iq,
    #     label: { text: 'What is your IQ?' },
    #     placeholder: 100,
    #     min: 80,
    #     max: 150,
    #     step: 5
    #
    # @example A number field with injected content
    #   = f.govuk_number_field :height_in_cm,
    #     label: { text: 'Height in centimetres' } do
    #
    #       p.govuk-inset-text
    #         | If you haven't measured your height in the last 6 months
    #           do it now
    #
    # @example A number field with the label supplied as a proc
    #   = f.govuk_url_field :personal_best_over_100m,
    #     label: -> { tag.h3("How many seconds does it take you to run 100m?") }
    #
    def govuk_number_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, form_group: {}, **args, &block)
      Elements::Inputs::Number.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, width: width, form_group: form_group, **args, &block).html
    end

    # Generates a +textarea+ element with a label, optional hint. Also offers
    # the ability to add the GOV.UK character and word counting components
    # automatically
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @param max_words [Integer] adds the GOV.UK max word count
    # @param max_chars [Integer] adds the GOV.UK max characters count
    # @param threshold [Integer] only show the +max_words+ and +max_chars+ warnings once a threshold (percentage) is reached
    # @param rows [Integer] sets the initial number of rows
    # @option args [Hash] args additional arguments are applied as attributes to the +textarea+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/textarea/ GOV.UK text area component
    # @see https://design-system.service.gov.uk/components/character-count GOV.UK character count component
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @note Setting +max_chars+ or +max_words+ will add a caption beneath the +textarea+ with a live count of words
    #   or characters
    #
    # @example A text area with a custom number of rows and a word limit
    #   = f.govuk_text_area :cv,
    #     label: { text: 'Tell us about your work history' },
    #     rows: 8,
    #     max_words: 300
    #
    # @example A text area with injected content
    #   = f.govuk_text_area :description,
    #     label: { text: 'Where did the incident take place?' } do
    #
    #     p.govuk-inset-text
    #       | If you don't know exactly leave this section blank
    #
    # @example A text area with the label supplied as a proc
    #   = f.govuk_text_area :instructions,
    #     label: -> { tag.h3("How do you set it up?") }
    #
    def govuk_text_area(attribute_name, hint: {}, label: {}, caption: {}, max_words: nil, max_chars: nil, rows: 5, threshold: nil, form_group: {}, **args, &block)
      Elements::TextArea.new(self, object_name, attribute_name, hint: hint, label: label, caption: caption, max_words: max_words, max_chars: max_chars, rows: rows, threshold: threshold, form_group: form_group, **args, &block).html
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
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param options [Hash] Options hash passed through to Rails' +collection_select+ helper
    # @param html_options [Hash] HTML Options hash passed through to Rails' +collection_select+ helper
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @see https://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-collection_select Rails collection_select (called by govuk_collection_select)
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A select box with hint
    #   = f.govuk_collection_select :grade,
    #     @grades,
    #     :id,
    #     :name,
    #     hint_text: "If you took the test more than once enter your highest grade"
    #
    # @example A select box with injected content
    #   = f.govuk_collection_select(:favourite_colour, @colours, :id, :name) do
    #
    #       p.govuk-inset-text
    #         | Select the closest match
    #
    # @example A select box with the label supplied as a proc
    #   = f.govuk_collection_select(:team, @teams, :id, :name) do
    #     label: -> { tag.h3("Which team did you represent?") }
    #
    def govuk_collection_select(attribute_name, collection, value_method, text_method, options: {}, html_options: {}, hint: {}, label: {}, caption: {}, form_group: {}, &block)
      Elements::Select.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method: value_method,
        text_method: text_method,
        hint: hint,
        label: label,
        caption: caption,
        options: options,
        html_options: html_options,
        form_group: form_group,
        &block
      ).html
    end

    # Generates a radio button for each item in the supplied collection
    #
    # @note Unlike the Rails +#collection_radio_buttons+ helper, this version can also insert
    #   hints per item in the collection by supplying a +:hint_method+
    #
    # @note +:bold_labels+, while false by default, is set to true when a
    #   +:hint_method+ is provided. This is done to make the label stand out more
    #   from the hint.
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol, Proc] The method called against each member of the collection to provide the value.
    #   When a +Proc+ is provided it must take a single argument that is a single member of the collection
    # @param text_method [Symbol, Proc, nil] The method called against each member of the collection to provide the label text.
    #   When a +Proc+ is provided it must take a single argument that is a single member of the collection.
    #   When a +nil+ value is provided the label text will be retrieved from the locale.
    # @param hint_method [Symbol, Proc, nil] The method called against each member of the collection to provide the hint text.
    #   When a +Proc+ is provided it must take a single argument that is a single member of the collection.
    #   When a +nil+ value is provided the hint text will be retrieved from the locale. This is the default and param can be omitted.
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param legend [Hash,Proc] options for configuring the legend
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @param small [Boolean] controls whether small radio buttons are used instead of regular-sized ones
    # @param bold_labels [Boolean] controls whether the radio button labels are bold
    # @param classes [Array,String] Classes to add to the radio button container.
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of radio buttons for favourite colours, labels capitalised via a proc
    #
    #  @colours = [
    #    OpenStruct.new(id: 'red', name: 'Red', description: 'Roses are red'),
    #    OpenStruct.new(id: 'blue', name: 'Blue', description: 'Violets are... purple?')
    #  ]
    #
    #  = f.govuk_collection_radio_buttons :favourite_colour,
    #    @colours,
    #    :id,
    #    ->(option) { option.name.upcase },
    #    :description,
    #    legend: { text: 'Pick your favourite colour', size: 'm' },
    #    hint_text: 'If you cannot find the exact match choose something close',
    #    inline: false
    #
    # @example A collection of radio buttons for grades with injected content
    #  = f.govuk_collection_radio_buttons :grade,
    #    @grades,
    #    :id,
    #    :name do
    #
    #      p.govuk-inset-text
    #        | If you took the test more than once enter your highest grade
    #
    # @example A collection of radio buttons with the legend supplied as a proc
    #  = f.govuk_collection_radio_buttons :category,
    #    @categories,
    #    :id,
    #    :name,
    #    legend: -> { tag.h3('Which category do you belong to?') }
    #
    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method, hint_method = nil, hint: {}, legend: {}, caption: {}, inline: false, small: false, bold_labels: false, classes: nil, form_group: {}, &block)
      Elements::Radios::Collection.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method: value_method,
        text_method: text_method,
        hint_method: hint_method,
        hint: hint,
        legend: legend,
        caption: caption,
        inline: inline,
        small: small,
        bold_labels: bold_labels,
        classes: classes,
        form_group: form_group,
        &block
      ).html
    end

    # Generates a radio button fieldset container and injects the supplied block contents
    #
    # @note The intention is to use {#govuk_radio_button} and {#govuk_radio_divider} within the passed-in block
    #
    # @note To ensure the {#govuk_error_summary} link functions correctly ensure the first {#govuk_radio_button}
    #   is set to +link_errors: true+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param legend [Hash,Proc] options for configuring the legend
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @param small [Boolean] controls whether small radio buttons are used instead of regular-sized ones
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] a block of HTML that will be used to populate the fieldset
    # @param classes [Array,String] Classes to add to the radio button container.
    # @see https://design-system.service.gov.uk/components/radios/ GOV.UK Radios
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A radio button fieldset for favourite colours with a divider
    #
    #  = f.govuk_radio_buttons_fieldset :favourite_colour, inline: false do
    #    = f.govuk_radio_button :favourite_colour, :red, label: { text: 'Red' }, link_errors: true
    #    = f.govuk_radio_button :favourite_colour, :green, label: { text: 'Green' }
    #    = f.govuk_radio_divider
    #    = f.govuk_radio_button :favourite_colour, :yellow, label: { text: 'Yellow' }
    #
    # @example A radio button fieldset with the legend supplied as a proc
    #  = f.govuk_radio_buttons_fieldset :burger_id do
    #    @burgers,
    #    :id,
    #    :name,
    #    legend: -> { tag.h3('Which hamburger do you want with your meal?') } do
    #      = f.govuk_radio_button :burger_id, :regular, label: { text: 'Hamburger' }, link_errors: true
    #      = f.govuk_radio_button :burger_id, :cheese, label: { text: 'Cheeseburger' }
    #
    def govuk_radio_buttons_fieldset(attribute_name, hint: {}, legend: {}, caption: {}, inline: false, small: false, classes: nil, form_group: {}, &block)
      Containers::RadioButtonsFieldset.new(self, object_name, attribute_name, hint: hint, legend: legend, caption: caption, inline: inline, small: small, classes: classes, form_group: form_group, &block).html
    end

    # Generates a radio button
    #
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] the contents of the hint
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @see https://design-system.service.gov.uk/components/radios/ GOV.UK Radios
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @param block [Block] Any supplied HTML will be wrapped in a conditional
    #   container and only revealed when the radio button is picked
    # @param link_errors [Boolean] controls whether this radio button should be linked to from {#govuk_error_summary}
    #   from the error summary. <b>Should only be set to +true+ for the first radio button in a fieldset</b>
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A single radio button for our new favourite colour
    #
    #  = f.govuk_radio_buttons_fieldset :favourite_colour do
    #    = f.govuk_radio_button :favourite_colour, :red, label: { text: 'Red' }
    #
    def govuk_radio_button(attribute_name, value, hint: {}, label: {}, link_errors: false, &block)
      Elements::Radios::FieldsetRadioButton.new(self, object_name, attribute_name, value, hint: hint, label: label, link_errors: link_errors, &block).html
    end

    # Inserts a text divider into a list of radio buttons
    #
    # @param text [String] The divider text
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @see https://design-system.service.gov.uk/components/radios/#radio-items-with-a-text-divider GOV.UK Radios with a text divider
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @example A custom divider
    #   = govuk_radio_divider 'Alternatively'
    def govuk_radio_divider(text = config.default_radio_divider_text)
      tag.div(text, class: %w(govuk-radios__divider))
    end

    # Generate a list of check boxes from a collection
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the label text
    # @param hint_method [Symbol, Proc] The method called against each member of the collection to provide the hint text.
    #   When a +Proc+ is provided it must take a single argument that is a single member of the collection
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param small [Boolean] controls whether small check boxes are used instead of regular-sized ones
    # @param classes [Array,String] Classes to add to the checkbox container.
    # @param legend [Hash,Proc] options for configuring the legend
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
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
    #    inline: false,
    #    classes: 'app-overflow-scroll',
    #
    # @example A collection of check boxes for types of bread
    #  = f.govuk_collection_check_boxes :bread,
    #    @variety,
    #    :id,
    #    :name do
    #
    #      p.govuk-inset-text
    #        | Only Hearty Italian is available with the meal deal menu
    #
    # @example A collection of check boxes with the legend supplied as a proc
    #  = f.govuk_collection_check_boxes :sandwich_type,
    #    @breads,
    #    :id,
    #    :name,
    #    legend: -> { tag.h3('What kind of sandwich do you want?') }
    #
    def govuk_collection_check_boxes(attribute_name, collection, value_method, text_method, hint_method = nil, hint: {}, legend: {}, caption: {}, small: false, classes: nil, form_group: {}, &block)
      Elements::CheckBoxes::Collection.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method: value_method,
        text_method: text_method,
        hint_method: hint_method,
        hint: hint,
        legend: legend,
        caption: caption,
        small: small,
        classes: classes,
        form_group: form_group,
        &block
      ).html
    end

    # Generate a fieldset intended to conatain one or more {#govuk_check_box}
    #
    # @note To ensure the {#govuk_error_summary} link functions correctly ensure the first {#govuk_check_box}
    #   is set to +link_errors: true+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] The content of the fieldset hint. No hint will be injected if left +nil+
    # @param small [Boolean] controls whether small check boxes are used instead of regular-sized ones
    # @param legend [Hash,Proc] options for configuring the legend
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @param classes [Array,String] Classes to add to the checkbox container.
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] a block of HTML that will be used to populate the fieldset
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A collection of check boxes for sandwich fillings
    #  = f.govuk_check_boxes_fieldset :desired_filling, legend: { text: 'Which filling do you want?' },
    #    = f.govuk_check_box :desired_filling, :cheese, label: { text: 'Cheese' }, link_errors: true
    #    = f.govuk_check_box :desired_filling, :tomato, label: { text: 'Tomato' }
    #
    # @example A collection of check boxes for drinks choices with legend as a proc
    #  = f.govuk_check_boxes_fieldset :drink_id, legend: -> { tag.h3('Choose drinks to accompany your meal') },
    #    = f.govuk_check_box :desired_filling, :lemonade, label: { text: 'Lemonade' }, link_errors: true
    #    = f.govuk_check_box :desired_filling, :fizzy_orange, label: { text: 'Fizzy orange' }
    #
    def govuk_check_boxes_fieldset(attribute_name, legend: {}, caption: {}, hint: {}, small: false, classes: nil, form_group: {}, &block)
      Containers::CheckBoxesFieldset.new(
        self,
        object_name,
        attribute_name,
        hint: hint,
        legend: legend,
        caption: caption,
        small: small,
        classes: classes,
        form_group: form_group,
        &block
      ).html
    end

    # Generates a single check box, intended for use within a {#govuk_check_boxes_fieldset}
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param value [Boolean,String,Symbol,Integer] The value of the checkbox when it is checked
    # @param hint_text [String] the contents of the hint
    # @param link_errors [Boolean] controls whether this radio button should be linked to from {#govuk_error_summary}
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
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
    def govuk_check_box(attribute_name, value, hint: {}, label: {}, link_errors: false, multiple: true, &block)
      Elements::CheckBoxes::FieldsetCheckBox.new(
        self,
        object_name,
        attribute_name,
        value,
        hint: hint,
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
    # @param classes [Array,String] Classes to add to the submit button
    # @param prevent_double_click [Boolean] adds JavaScript to safeguard the
    #   form from being submitted more than once
    # @param validate [Boolean] adds the formnovalidate to the submit button when true, this disables all
    #   client-side validation provided by the browser. This is to provide a more consistent and accessible user
    #   experience
    # @param disabled [Boolean] makes the button disabled when true
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
    def govuk_submit(text = config.default_submit_button_text, warning: false, secondary: false, classes: nil, prevent_double_click: true, validate: false, disabled: false, &block)
      Elements::Submit.new(self, text, warning: warning, secondary: secondary, classes: classes, prevent_double_click: prevent_double_click, validate: validate, disabled: disabled, &block).html
    end

    # Generates three inputs for the +day+, +month+ and +year+ components of a date
    #
    # @note When using this input be aware that Rails's multiparam time and date handling falls foul
    #   of {https://bugs.ruby-lang.org/issues/5988 this} bug, so incorrect dates like +2019-09-31+ will
    #   be 'rounded' up to +2019-10-01+.
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint_text [String] the contents of the hint
    # @param legend [Hash,Proc] options for configuring the legend
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @param omit_day [Boolean] do not render a day input, only capture month and year
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input group
    # @param date_of_birth [Boolean] if +true+ {https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete#Values birth date auto completion attributes}
    #   will be added to the inputs
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @see https://github.com/alphagov/govuk-frontend/issues/1449 GOV.UK date input element attributes, using text instead of number
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A regular date input with a legend, hint and injected content
    #   = f.govuk_date_field :starts_on,
    #     legend: { 'When does your event start?' },
    #     hint_text: 'Leave this field blank if you don't know exactly' } do
    #
    #       p.govuk-inset-text
    #         | If you don't fill this in you won't be eligable for a refund
    #
    # @example A date input with legend supplied as a proc
    #  = f.govuk_date_field :finishes_on,
    #    legend: -> { tag.h3('Which category do you belong to?') }
    def govuk_date_field(attribute_name, hint: {}, legend: {}, caption: {}, date_of_birth: false, omit_day: false, form_group: {}, &block)
      Elements::Date.new(self, object_name, attribute_name, hint: hint, legend: legend, caption: caption, date_of_birth: date_of_birth, omit_day: omit_day, form_group: form_group, &block).html
    end

    # Generates a summary of errors in the form, each linking to the corresponding
    # part of the form that contains the error
    #
    # @param title [String] the error summary heading
    #
    # @example An error summary with a custom title
    #   = f.govuk_error_summary 'Uh-oh, spaghettios'
    #
    # @see https://design-system.service.gov.uk/components/error-summary/ GOV.UK error summary
    def govuk_error_summary(title = config.default_error_summary_title)
      Elements::ErrorSummary.new(self, object_name, title).html
    end

    # Generates a fieldset containing the contents of the block
    #
    # @param legend [Hash,Proc] options for configuring the legend
    # @param described_by [Array<String>] the ids of the elements that describe this fieldset, usually hints and errors
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    #
    # @example A fieldset containing address fields
    #   = f.govuk_fieldset legend: { text: 'Address' }
    #     = f.govuk_text_field :street
    #     = f.govuk_text_field :town
    #     = f.govuk_text_field :city
    #
    # @example A fieldset with the legend as a proc
    #   = f.govuk_fieldset legend: -> { tag.h3('Skills') }
    #     = f.govuk_text_area :physical
    #     = f.govuk_text_area :mental
    #
    # @see https://design-system.service.gov.uk/components/fieldset/ GOV.UK fieldset
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @return [ActiveSupport::SafeBuffer] HTML output
    def govuk_fieldset(legend: { text: 'Fieldset heading' }, caption: {}, described_by: nil, &block)
      Containers::Fieldset.new(self, legend: legend, caption: caption, described_by: described_by, &block).html
    end

    # Generates an input of type +file+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @option label text [String] the label text
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @param hint_text [String] The content of the hint. No hint will be injected if left +nil+
    # @option args [Hash] args additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group classes [Array,String] sets the form group's classes
    # @option form_group args [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    #
    # @example A photo upload field with file type specifier and injected content
    #   = f.govuk_file_field :photo, label: { text: 'Upload your photo' }, accept: 'image/*' do
    #
    #     p.govuk-inset-text
    #       | Explicit images will result in account termination
    #
    # @example A CV upload field with label as a proc
    #   = f.govuk_file_field :cv, label: -> { tag.h3('Upload your CV') }
    #
    # @see https://design-system.service.gov.uk/components/file-upload/ GOV.UK file upload
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file MDN documentation for file upload
    #
    # @note Remember to set +multipart: true+ when creating a form with file
    #   uploads, {https://guides.rubyonrails.org/form_helpers.html#uploading-files see
    #   the Rails documentation} for more information
    def govuk_file_field(attribute_name, label: {}, caption: {}, hint: {}, form_group: {}, **args, &block)
      Elements::File.new(self, object_name, attribute_name, label: label, caption: caption, hint: hint, form_group: form_group, **args, &block).html
    end
  end
end
