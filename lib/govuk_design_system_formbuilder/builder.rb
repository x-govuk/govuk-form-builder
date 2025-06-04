module GOVUKDesignSystemFormBuilder
  module Builder
    delegate :config, to: GOVUKDesignSystemFormBuilder

    # Generates a form label without a form group or input
    # @param text [String] the label text
    # @param size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @param tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @param hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @param kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    #
    # @example A standalone label for the name field
    #   = f.govuk_label :name, text: 'Full name', size: 'l', caption: { text: 'It must match your driving licence' }
    #
    def govuk_label(attribute_name, text: nil, size: nil, hidden: false, tag: nil, caption: nil, **kwargs)
      GOVUKDesignSystemFormBuilder::Elements::Label.new(self, object_name, attribute_name, text:, size:, hidden:, tag:, caption:, **kwargs).html
    end

    # Generates a input of type +text+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    #
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
    #   sequences of letters and numbers. Defaults to +false+.
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
    # @param suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A required full name field with a placeholder
    #   = f.govuk_text_field :name,
    #     label: { text: 'Full name' },
    #     hint: { text: 'It says it on your birth certificate' },
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
    def govuk_text_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, extra_letter_spacing: false, form_group: {}, prefix_text: nil, suffix_text: nil, **kwargs, &block)
      Elements::Inputs::Text.new(self, object_name, attribute_name, hint:, label:, caption:, width:, extra_letter_spacing:, form_group:, prefix_text:, suffix_text:, **kwargs, &block).html
    end

    # Generates a input of type +tel+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
    #   sequences of letters and numbers. Defaults to +false+.
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
    # @param suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @see https://design-system.service.gov.uk/components/text-input/ GOV.UK Text input
    # @see https://design-system.service.gov.uk/patterns/telephone-numbers/ GOV.UK Telephone number patterns
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    #
    # @example A required phone number field with a placeholder
    #   = f.govuk_phone_field :phone_number,
    #     label: { text: 'UK telephone number' },
    #     hint: { text: 'Include the dialling code' },
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
    def govuk_phone_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, extra_letter_spacing: false, form_group: {}, prefix_text: nil, suffix_text: nil, **kwargs, &block)
      Elements::Inputs::Phone.new(self, object_name, attribute_name, hint:, label:, caption:, width:, extra_letter_spacing:, form_group:, prefix_text:, suffix_text:, **kwargs, &block).html
    end

    # Generates a input of type +email+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
    #   sequences of letters and numbers. Defaults to +false+.
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
    # @param suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
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
    def govuk_email_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, extra_letter_spacing: false, form_group: {}, prefix_text: nil, suffix_text: nil, **kwargs, &block)
      Elements::Inputs::Email.new(self, object_name, attribute_name, hint:, label:, caption:, width:, extra_letter_spacing:, form_group:, prefix_text:, suffix_text:, **kwargs, &block).html
    end

    # Generates a input of type +url+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
    #   sequences of letters and numbers. Defaults to +false+.
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
    # @param suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
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
    def govuk_url_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, extra_letter_spacing: false, form_group: {}, prefix_text: nil, suffix_text: nil, **kwargs, &block)
      Elements::Inputs::URL.new(self, object_name, attribute_name, hint:, label:, caption:, width:, extra_letter_spacing:, form_group:, prefix_text:, suffix_text:, **kwargs, &block).html
    end

    # Generates a input of type +number+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param width [Integer,String] sets the width of the input, can be +2+, +3+ +4+, +5+, +10+ or +20+ characters
    #   or +one-quarter+, +one-third+, +one-half+, +two-thirds+ or +full+ width of the container
    # @param extra_letter_spacing [Boolean] when true adds space between characters to increase the readability of
    #   sequences of letters and numbers. Defaults to +false+.
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param prefix_text [String] the text placed before the input. No prefix will be added if left +nil+
    # @param suffix_text [String] the text placed after the input. No suffix will be added if left +nil+
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
    def govuk_number_field(attribute_name, hint: {}, label: {}, caption: {}, width: nil, extra_letter_spacing: false, form_group: {}, prefix_text: nil, suffix_text: nil, **kwargs, &block)
      Elements::Inputs::Number.new(self, object_name, attribute_name, hint:, label:, caption:, width:, extra_letter_spacing:, form_group:, prefix_text:, suffix_text:, **kwargs, &block).html
    end

    # Generates a password input
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param show_password_text [String] button text when the password is hidden. Defaults to "Show"
    # @param hide_password_text [String] button text when the password is shown. Defaults to "Hide"
    # @param show_password_aria_label_text [String] button text exposed to assistive technologies, like screen readers, when the password is hidden. Defaults to "Show password"
    # @param hide_password_aria_label_text [String] button text exposed to assistive technologies, like screen readers, when the password is visible. Defaults to "Hide password"
    # @param password_shown_announcement_text [String] Announcement made to screen reader users when their password has become visible in plain text. Defaults to "Your password is visible"
    # @param password_hidden_announcement_text [String] Announcement made to screen reader users when their password has been obscured and is not visible. Defaults to "Your password is hidden"
    #
    # @example A password field
    #   = f.govuk_password_field :password
    #
    def govuk_password_field(
      attribute_name,
      hint: {},
      label: {},
      caption: {},
      form_group: {},
      show_password_text: config.default_show_password_text,
      hide_password_text: config.default_hide_password_text,
      show_password_aria_label_text: config.default_show_password_aria_label_text,
      hide_password_aria_label_text: config.default_hide_password_aria_label_text,
      password_shown_announcement_text: config.default_password_shown_announcement_text,
      password_hidden_announcement_text: config.default_password_hidden_announcement_text,
      **kwargs,
      &block
    )
      Elements::Password.new(
        self,
        object_name,
        attribute_name,
        hint:,
        label:,
        caption:,
        form_group:,
        show_password_text:,
        hide_password_text:,
        show_password_aria_label_text:,
        hide_password_aria_label_text:,
        password_shown_announcement_text:,
        password_hidden_announcement_text:,
        **kwargs,
        &block
      ).html
    end

    # Generates a +textarea+ element with a label, optional hint. Also offers
    # the ability to add the GOV.UK character and word counting components
    # automatically
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @param max_words [Integer] adds the GOV.UK max word count
    # @param max_chars [Integer] adds the GOV.UK max characters count
    # @param threshold [Integer] only show the +max_words+ and +max_chars+ warnings once a threshold (percentage) is reached
    # @param rows [Integer] sets the initial number of rows
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +textarea+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +textarea+ element
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
    def govuk_text_area(attribute_name, hint: {}, label: {}, caption: {}, max_words: nil, max_chars: nil, rows: 5, threshold: nil, form_group: {}, **kwargs, &block)
      Elements::TextArea.new(self, object_name, attribute_name, hint:, label:, caption:, max_words:, max_chars:, rows:, threshold:, form_group:, **kwargs, &block).html
    end

    # Generates a +select+ element containing +option+ for each member in the provided collection
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the text
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param options [Hash] Options hash passed through to Rails' +collection_select+ helper
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param block [Block] arbitrary HTML that will be rendered between the hint and the input
    # @see https://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-collection_select Rails collection_select (called by govuk_collection_select)
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A select box with hint
    #   = f.govuk_collection_select :grade,
    #     @grades,
    #     :id,
    #     :name,
    #     hint: { text: "If you took the test more than once enter your highest grade" }
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
    def govuk_collection_select(attribute_name, collection, value_method, text_method, options: {}, hint: {}, label: {}, caption: {}, form_group: {}, **kwargs, &block)
      Elements::CollectionSelect.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method:,
        text_method:,
        hint:,
        label:,
        caption:,
        options:,
        form_group:,
        **kwargs,
        &block
      ).html
    end

    # Generates a +select+ element containing an +option+ for every choice provided
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param choices [Array,Hash] The +option+ values, usually provided via
    #   the +options_for_select+ or +grouped_options_for_select+ helpers.
    # @param options [Hash] Options hash passed through to Rails' +select+ helper
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param block [Block] build the contents of the select element manually for exact control
    # @see https://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html#method-i-select Rails select (called by govuk_collection_select)
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A select box with custom data attributes
    #
    #   @colours = [
    #     ["PapayaWhip", "pw",  { data: { hex: "#ffefd5" } }],
    #     ["Chocolate", "choc", { data: { hex: "#d2691e" } }],
    #   ]
    #
    #   = f.govuk_select :hat_colour, options_for_select(@colours)
    #
    def govuk_select(attribute_name, choices = nil, options: {}, label: {}, hint: {}, form_group: {}, caption: {}, **kwargs, &block)
      Elements::Select.new(self, object_name, attribute_name, choices, options:, label:, hint:, form_group:, caption:, **kwargs, &block).html
    end

    # Generates a radio button for each item in the supplied collection
    #
    # @note Unlike the Rails +#collection_radio_buttons+ helper, this version can also insert
    #   hints per item in the collection by supplying a +:hint_method+
    #
    # @note +:bold_labels+, is +nil+ (falsy) by default. When a +:hint_method+
    #       is provided it will become +true+ to make the label stand out more
    #       from the hint. The choice can be overridden with +true+ or +false+.
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
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param legend [NilClass,Hash,Proc] options for configuring the legend. Legend will be omitted if +nil+.
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @param small [Boolean] controls whether small radio buttons are used instead of regular-sized ones
    # @param bold_labels [Boolean] controls whether the radio button labels are bold
    # @param include_hidden [Boolean] controls whether a hidden field is inserted to allow for empty submissions
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+.
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @option legend kwargs [Hash] additional arguments are applied as attributes on the +legend+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
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
    #    hint: { text: 'If you cannot find the exact match choose something close' },
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
    def govuk_collection_radio_buttons(attribute_name, collection, value_method, text_method = nil, hint_method = nil, hint: {}, legend: {}, caption: {}, inline: false, small: false, bold_labels: nil, include_hidden: config.default_collection_radio_buttons_include_hidden, form_group: {}, **kwargs, &block)
      Elements::Radios::Collection.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method:,
        text_method:,
        hint_method:,
        hint:,
        legend:,
        caption:,
        inline:,
        small:,
        bold_labels:,
        form_group:,
        include_hidden:,
        **kwargs,
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
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param legend [NilClass,Hash,Proc] options for configuring the legend. Legend will be omitted if +nil+.
    # @param inline [Boolean] controls whether the radio buttons are displayed inline or not
    # @param small [Boolean] controls whether small radio buttons are used instead of regular-sized ones
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+.
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @option legend kwargs [Hash] additional arguments are applied as attributes on the +legend+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param block [Block] a block of HTML that will be used to populate the fieldset
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
    def govuk_radio_buttons_fieldset(attribute_name, hint: {}, legend: {}, caption: {}, inline: false, small: false, form_group: {}, **kwargs, &block)
      Containers::RadioButtonsFieldset.new(self, object_name, attribute_name, hint:, legend:, caption:, inline:, small:, form_group:, **kwargs, &block).html
    end

    # Generates a radio button
    #
    # @note This should only be used from within a {#govuk_radio_buttons_fieldset}
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param label [Hash,Proc] configures or sets the associated label content
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @see https://design-system.service.gov.uk/components/radios/ GOV.UK Radios
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @param block [Block] Any supplied HTML will be wrapped in a conditional
    #   container and only revealed when the radio button is picked
    # @param link_errors [Boolean] controls whether this radio button should be linked to from {#govuk_error_summary}
    #   from the error summary. <b>Should only be set to +true+ for the first radio button in a fieldset</b>
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A single radio button for our new favourite colour
    #
    #  = f.govuk_radio_buttons_fieldset :favourite_colour do
    #    = f.govuk_radio_button :favourite_colour, :red, label: { text: 'Red' }
    #
    def govuk_radio_button(attribute_name, value, hint: {}, label: {}, link_errors: false, **kwargs, &block)
      Elements::Radios::FieldsetRadioButton.new(self, object_name, attribute_name, value, hint:, label:, link_errors:, **kwargs, &block).html
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
      tag.div(text, class: %(#{config.brand}-radios__divider))
    end

    # Generate a list of check boxes from a collection
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param collection [Enumerable<Object>] Options to be added to the +select+ element
    # @param value_method [Symbol] The method called against each member of the collection to provide the value
    # @param text_method [Symbol] The method called against each member of the collection to provide the label text
    # @param hint_method [Symbol, Proc] The method called against each member of the collection to provide the hint text.
    #   When a +Proc+ is provided it must take a single argument that is a single member of the collection
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param small [Boolean] controls whether small check boxes are used instead of regular-sized ones
    # @param legend [NilClass,Hash,Proc] options for configuring the legend. Legend will be omitted if +nil+.
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+.
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param include_hidden [Boolean] controls whether a hidden field is inserted to allow for empty submissions
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
    #    hint: { text: "If it isn't listed here, tough luck" },
    #    inline: false,
    #    class: 'app-overflow-scroll',
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
    def govuk_collection_check_boxes(attribute_name, collection, value_method, text_method, hint_method = nil, hint: {}, legend: {}, caption: {}, small: false, form_group: {}, include_hidden: config.default_collection_check_boxes_include_hidden, **kwargs, &block)
      Elements::CheckBoxes::Collection.new(
        self,
        object_name,
        attribute_name,
        collection,
        value_method:,
        text_method:,
        hint_method:,
        hint:,
        legend:,
        caption:,
        small:,
        form_group:,
        include_hidden:,
        **kwargs,
        &block
      ).html
    end

    # Generate a fieldset intended to conatain one or more {#govuk_check_box}
    #
    # @note To ensure the {#govuk_error_summary} link functions correctly ensure the first {#govuk_check_box}
    #   is set to +link_errors: true+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param small [Boolean] controls whether small check boxes are used instead of regular-sized ones
    # @param legend [NilClass,Hash,Proc] options for configuring the legend. Legend will be omitted if +nil+.
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+.
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @option legend kwargs [Hash] additional arguments are applied as attributes on the +legend+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @param form_group [Hash] configures the form group
    # @param multiple [Boolean] when true adds a +[]+ suffix the +name+ of the automatically-generated hidden field
    #   (ie. <code>project[invoice_attributes][]</code>). When false, no +[]+ suffix is added (ie. <code>project[accepted]</code>)
    # @option form_group kwargs [Hash] additional attributes added to the form group
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
    def govuk_check_boxes_fieldset(attribute_name, legend: {}, caption: {}, hint: {}, small: false, form_group: {}, multiple: true, **kwargs, &block)
      Containers::CheckBoxesFieldset.new(
        self,
        object_name,
        attribute_name,
        hint:,
        legend:,
        caption:,
        small:,
        form_group:,
        multiple:,
        **kwargs,
        &block
      ).html
    end

    # Generates a single check box, intended for use within a {#govuk_check_boxes_fieldset}
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @param value [Boolean,String,Symbol,Integer] The value of the checkbox when it is checked
    # @param unchecked_value [Boolean,String,Symbol,Integer] The value of the checkbox when it is unchecked
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param link_errors [Boolean] controls whether this radio button should be linked to from {#govuk_error_summary}
    # @option label text [String] the label text
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param multiple [Boolean] controls whether the check box is part of a collection or represents a single attribute
    # @param exclusive [Boolean] sets the checkbox so that when checked none of its siblings can be too. Usually
    #   used for the 'None of these apply to me' option found beneath a {#govuk_check_box_divider}.
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param block [Block] any HTML passed in will form the contents of the fieldset
    # @return [ActiveSupport::SafeBuffer] HTML output
    #
    # @example A single check box for terms and conditions
    #   = f.govuk_check_box :terms_agreed,
    #     true,
    #     multiple: false,
    #     link_errors: true,
    #     label: { text: 'Do you agree with our terms and conditions?' },
    #     hint: { text: 'You will not be able to proceed unless you do' }
    #
    def govuk_check_box(attribute_name, value, unchecked_value = false, hint: {}, label: {}, link_errors: false, multiple: true, exclusive: false, **kwargs, &block)
      Elements::CheckBoxes::FieldsetCheckBox.new(
        self,
        object_name,
        attribute_name,
        value,
        unchecked_value,
        hint:,
        label:,
        link_errors:,
        multiple:,
        exclusive:,
        **kwargs,
        &block
      ).html
    end

    # Inserts a text divider into a list of check boxes
    #
    # @param text [String] The divider text
    # @note This should only be used from within a {#govuk_check_boxes_fieldset}
    # @see https://design-system.service.gov.uk/components/checkboxes/#add-an-option-for-none- GOV.UK check boxes with a text divider
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @example A custom divider
    #   = govuk_check_box_divider 'On the other hand'
    def govuk_check_box_divider(text = config.default_check_box_divider_text)
      tag.div(text, class: %w(govuk-checkboxes__divider))
    end

    # Generates a submit button, green by default
    #
    # @param text [String,Proc] the button text. When a +Proc+ is provided its contents will be rendered within the button element
    # @param warning [Boolean] makes the button red ({https://design-system.service.gov.uk/components/button/#warning-buttons warning}) when true
    # @param secondary [Boolean] makes the button grey ({https://design-system.service.gov.uk/components/button/#secondary-buttons secondary}) when true
    # @param inverse [Boolean] inverts the colours of the button. Note this isn't yet part of the design system.
    # @param prevent_double_click [Boolean] adds JavaScript to safeguard the
    #   form from being submitted more than once
    # @param validate [Boolean] adds the formnovalidate to the submit button when true, this disables all
    #   client-side validation provided by the browser. This is to provide a more consistent and accessible user
    #   experience
    # @param disabled [Boolean] makes the button disabled when true
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +button+ element
    # @param block [Block] When content is passed in via a block the submit element and the block content will
    #   be wrapped in a +<div class="govuk-button-group">+ which will space the buttons and links within
    #   evenly.
    # @raise [ArgumentError] raised if both +warning+ and +secondary+ are true
    # @return [ActiveSupport::SafeBuffer] HTML output
    # @note Only the first additional button or link (passed in via a block) will be given the
    #   correct left margin, subsequent buttons will need to be manually accounted for
    # @note This helper always renders an +<button type='submit'>+ tag. Previous versions of this gem rendered
    #   a +`<input type='submit'>' tag instead, but there is a {https://github.com/alphagov/govuk_elements/issues/545 longstanding bug}
    #   with this approach where the top few pixels don't initiate a submission when clicked.
    # @see https://design-system.service.gov.uk/components/button/#stop-users-from-accidentally-sending-information-more-than-once
    #   GOV.UK double click prevention
    #
    # @example A submit button with custom text, double click protection and an inline cancel link
    #   = f.govuk_submit "Proceed", prevent_double_click: true do
    #     = link_to 'Cancel', some_other_path, class: 'govuk-button__secondary'
    #
    def govuk_submit(text = config.default_submit_button_text, warning: false, secondary: false, inverse: false, prevent_double_click: true, validate: config.default_submit_validate, disabled: false, **kwargs, &block)
      Elements::Submit.new(self, text, warning:, secondary:, inverse:, prevent_double_click:, validate:, disabled:, **kwargs, &block).html
    end

    # Generates three inputs for the +day+, +month+ and +year+ components of a date
    #
    # @note When using this input be aware that Rails's multiparam time and date handling falls foul
    #   of {https://bugs.ruby-lang.org/issues/5988 this} bug, so incorrect dates like +2019-09-31+ will
    #   be 'rounded' up to +2019-10-01+.
    # @note When using this input values will be retrieved from the attribute if it is a Date object or a multiparam date hash
    # @param attribute_name [Symbol] The name of the attribute
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @param legend [NilClass,Hash,Proc] options for configuring the legend. Legend will be omitted if +nil+.
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+.
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @option legend kwargs [Hash] additional arguments are applied as attributes on the +legend+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the legend
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @param omit_day [Boolean] do not render a day input, only capture month and year
    # @param maxlength_enabled [Boolean] adds maxlength attribute to day, month and year inputs (2, 2, and 4, respectively)
    # @param segments [Hash] allows Rails' multiparameter attributes to be overridden on a field-by-field basis. Hash must
    #   contain +day:+, +month:+ and +year:+ keys. Defaults to the default value set in the +default_date_segments+ setting in {GOVUKDesignSystemFormBuilder.DEFAULTS}
    # @param segment_names [Hash] allows the day, month and year labels to be overridden. Hash must
    #   contain +day:+, +month:+ and +year:+ keys. Defaults to the default value set in the +default_date_segment_names+ setting in {GOVUKDesignSystemFormBuilder.DEFAULTS}
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
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
    #     hint: { text: 'Leave this field blank if you don't know exactly' } do
    #
    #       p.govuk-inset-text
    #         | If you don't fill this in you won't be eligable for a refund
    #
    # @example A date input with legend supplied as a proc
    #  = f.govuk_date_field :finishes_on,
    #    legend: -> { tag.h3('Which category do you belong to?') }
    def govuk_date_field(attribute_name, hint: {}, legend: {}, caption: {}, date_of_birth: false, omit_day: false, maxlength_enabled: false, segments: config.default_date_segments, segment_names: config.default_date_segment_names, form_group: {}, **kwargs, &block)
      Elements::Date.new(self, object_name, attribute_name, hint:, legend:, caption:, date_of_birth:, omit_day:, maxlength_enabled:, segments:, segment_names:, form_group:, **kwargs, &block).html
    end

    # Generates a summary of errors in the form, each linking to the corresponding
    # part of the form that contains the error
    #
    # @param title [String] the error summary heading
    # @param link_base_errors_to [Symbol,String] set the field that errors on +:base+ are linked
    #   to, as there won't be a field representing the object base.
    # @param order [Array<Symbol>] the attribute order in which error messages are displayed. Ordered
    #   attributes will appear first and unordered ones will be last, sorted in the default manner (in
    #   which they were defined on the model).
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the error summary +div+ element
    # @param block [Block] arbitrary HTML that will be rendered between title and error message list
    # @param presenter [Class,Object] the class or object that is responsible for formatting a list of error
    #   messages that will be rendered in the summary.
    #
    #   * When a class is specified it will be instantiated with the object's errors in the +object.errors.messages+ format.
    #   * When an object is specified it will be used as-is.
    #
    #   The object must implement +#formatted_error_messages+, see {Presenters::ErrorSummaryPresenter} for more details.
    #
    # @note Only the first error in the +#errors+ array for each attribute will
    #   be included.
    #
    # @example An error summary with a custom title
    #   = f.govuk_error_summary 'Uh-oh, spaghettios'
    #
    # @see https://design-system.service.gov.uk/components/error-summary/ GOV.UK error summary
    def govuk_error_summary(title = config.default_error_summary_title, presenter: config.default_error_summary_presenter, link_base_errors_to: nil, order: nil, **kwargs, &block)
      Elements::ErrorSummary.new(self, object_name, title, link_base_errors_to:, order:, presenter:, **kwargs, &block).html
    end

    # Generates a fieldset containing the contents of the block
    #
    # @param legend [NilClass,Hash,Proc] options for configuring the legend. Legend will be omitted if +nil+.
    # @param described_by [Array<String>] the ids of the elements that describe this fieldset, usually hints and errors
    # @option legend text [String] the fieldset legend's text content
    # @option legend size [String] the size of the fieldset legend font, can be +xl+, +l+, +m+ or +s+
    # @option legend tag [Symbol,String] the tag used for the fieldset's header, defaults to +h1+.
    # @option legend hidden [Boolean] control the visibility of the legend. Hidden legends will still be read by screenreaders
    # @option legend kwargs [Hash] additional arguments are applied as attributes on the +legend+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    #
    # @example A fieldset containing address fields
    #   = f.govuk_fieldset legend: { text: 'Address' } do
    #     = f.govuk_text_field :street
    #     = f.govuk_text_field :town
    #     = f.govuk_text_field :city
    #
    # @example A fieldset with the legend as a proc
    #   = f.govuk_fieldset legend: -> { tag.h3('Skills') } do
    #     = f.govuk_text_area :physical
    #     = f.govuk_text_area :mental
    #
    # @see https://design-system.service.gov.uk/components/fieldset/ GOV.UK fieldset
    # @see https://design-system.service.gov.uk/styles/typography/#headings-with-captions Headings with captions
    # @return [ActiveSupport::SafeBuffer] HTML output
    def govuk_fieldset(legend: { text: 'Fieldset heading' }, caption: {}, described_by: nil, **kwargs, &block)
      Containers::Fieldset.new(self, legend:, caption:, described_by:, **kwargs, &block).html
    end

    # Generates an input of type +file+
    #
    # @param attribute_name [Symbol] The name of the attribute
    # @option label text [String] the label text
    # @option label tag [Symbol,String] the label's wrapper tag, intended to allow labels to act as page headings
    # @option label size [String] the size of the label font, can be +xl+, +l+, +m+, +s+ or nil
    # @option label hidden [Boolean] control the visability of the label. Hidden labels will stil be read by screenreaders
    # @option label kwargs [Hash] additional arguments are applied as attributes on the +label+ element
    # @param caption [Hash] configures or sets the caption content which is inserted above the label
    # @option caption text [String] the caption text
    # @option caption size [String] the size of the caption, can be +xl+, +l+ or +m+. Defaults to +m+
    # @option caption kwargs [Hash] additional arguments are applied as attributes on the caption +span+ element
    # @param hint [Hash,Proc] The content of the hint. No hint will be added if 'text' is left +nil+. When a +Proc+ is
    #   supplied the hint will be wrapped in a +div+ instead of a +span+
    # @option hint text [String] the hint text
    # @option hint kwargs [Hash] additional arguments are applied as attributes to the hint
    # @option kwargs [Hash] kwargs additional arguments are applied as attributes to the +input+ element
    # @param form_group [Hash] configures the form group
    # @option form_group kwargs [Hash] additional attributes added to the form group
    # @param javascript [Boolean] Configures whether to add HTML for the javascript-enhanced version of the component
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
    def govuk_file_field(attribute_name, label: {}, caption: {}, hint: {}, form_group: {}, javascript: false, **kwargs, &block)
      Elements::File.new(self, object_name, attribute_name, label:, caption:, hint:, form_group:, javascript:, **kwargs, &block).html
    end
  end
end
