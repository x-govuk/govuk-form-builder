describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_password_field' do
    let(:method) { :govuk_password_field }
    let(:attribute) { :password }
    let(:label_text) { 'Enter your password' }
    let(:hint_text) { 'Keep it safe' }
    let(:args) { [method, attribute] }
    let(:kwargs) { {} }
    let(:field_type) { 'input' }
    subject { builder.send(*args, **kwargs) }

    specify 'renders a form group containing a wrapper around an input and button' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        with_tag('div', with: { class: %w(govuk-input__wrapper govuk-password-input__wrapper) }) do
          with_tag('input', with: { type: 'password' })
          with_tag('button')
        end
      end
    end

    specify 'the form group has the password data module' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group', "data-module" => "govuk-password-input" })
    end

    specify 'the password input has the right classes' do
      expect(subject).to have_tag('input', with: { class: %w(govuk-input govuk-password-input__input govuk-js-password-input-input) })
    end

    specify 'the password input has the right attributes' do
      expect(subject).to have_tag(
        'input',
        with: {
          id: "person-password-field",
          spellcheck: false,
          autocomplete: "current-password",
          autocapitalize: "none"
        }
      )
    end

    specify 'the button has the right classes' do
      expected_classes = %w(govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle)

      expect(subject).to have_tag('button', with: { class: expected_classes })
    end

    specify 'the button has the right attributes' do
      expected_attributes = {
        "data-module" => "govuk-button",
        "aria-label" => "Show password",
        "aria-controls" => "person-password-field",
      }

      expect(subject).to have_tag('button', with: expected_attributes)
    end

    specify 'the button has the right classes' do
      expect(subject).to have_tag(
        'button',
        with: {
          class: %w(govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle)
        }
      )
    end

    describe 'customising the show and hide text' do
      let(:xpath_password_module_selector) { %(./div[@data-module="govuk-password-input"]) }
      let(:i18n_data_attributes) do
        %w(
          data-i18n.hide-password
          data-i18n.show-password-aria-label
          data-i18n.hide-password-aria-label
          data-i18n.password-shown-announcement
          data-i18n.password-hidden-announcement
        )
      end

      context 'when the show button text is customised' do
        let(:show_password_key) { "data-i18n.show-password" }
        let(:custom_show_password_text) { "Reveal" }
        let(:kwargs) { { show_password_text: custom_show_password_text } }

        specify "the show button has the provided text" do
          expect(subject).to have_tag("button", text: custom_show_password_text)
        end

        specify 'the show button has the the corresponding i18n data attribute set' do
          show_password_attr = parsed_subject.at_xpath(xpath_password_module_selector).attributes.fetch(show_password_key).value

          expect(show_password_attr).to eql(custom_show_password_text)
        end

        specify 'no other i18n data attributes are set' do
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).to include(show_password_key)
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).not_to include(*i18n_data_attributes.excluding(show_password_key))
        end
      end

      context 'when the hide button text is customised' do
        let(:hide_password_key) { "data-i18n.hide-password" }
        let(:custom_hide_password_text) { "Conceal" }
        let(:kwargs) { { hide_password_text: custom_hide_password_text } }

        specify 'the hide button has the the corresponding i18n data attribute set' do
          hide_password_attr = parsed_subject.at_xpath(xpath_password_module_selector).attributes.fetch(hide_password_key).value

          expect(hide_password_attr).to eql(custom_hide_password_text)
        end

        specify 'no other i18n data attributes are set' do
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).to include(hide_password_key)
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).not_to include(*i18n_data_attributes.excluding(hide_password_key))
        end
      end

      context 'when the hide password aria label is customised' do
        let(:hide_password_key) { "data-i18n.show-password-aria-label" }
        let(:custom_show_password_aria_label_text) { "Secrete the password" }
        let(:kwargs) { { show_password_aria_label_text: custom_show_password_aria_label_text } }

        specify 'the hide button has the the corresponding i18n data attribute set' do
          hide_password_attr = parsed_subject.at_xpath(xpath_password_module_selector).attributes.fetch(hide_password_key).value

          expect(hide_password_attr).to eql(custom_show_password_aria_label_text)
        end

        specify 'no other i18n data attributes are set' do
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).to include(hide_password_key)
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).not_to include(*i18n_data_attributes.excluding(hide_password_key))
        end
      end

      context 'when the hide password aria label is customised' do
        let(:hide_password_aria_label_key) { "data-i18n.hide-password-aria-label" }
        let(:custom_hide_password_aria_label_text) { "Obscure the password" }
        let(:kwargs) { { hide_password_aria_label_text: custom_hide_password_aria_label_text } }

        specify 'the hide button has the the corresponding i18n data attribute set' do
          hide_password_attr = parsed_subject.at_xpath(xpath_password_module_selector).attributes.fetch(hide_password_aria_label_key).value

          expect(hide_password_attr).to eql(custom_hide_password_aria_label_text)
        end

        specify 'no other i18n data attributes are set' do
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).to include(hide_password_aria_label_key)
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).not_to include(*i18n_data_attributes.excluding(hide_password_aria_label_key))
        end
      end

      context 'when the password shown announcement text is customised' do
        let(:password_shown_announcement_text_key) { "data-i18n.password-shown-announcement" }
        let(:custom_password_shown_announcement_text) { "The password has been revealed" }
        let(:kwargs) { { password_shown_announcement_text: custom_password_shown_announcement_text } }

        specify 'the show button has the the corresponding i18n data attribute set' do
          show_password_attr = parsed_subject.at_xpath(xpath_password_module_selector).attributes.fetch(password_shown_announcement_text_key).value

          expect(show_password_attr).to eql(custom_password_shown_announcement_text)
        end

        specify 'no other i18n data attributes are set' do
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).to include(password_shown_announcement_text_key)
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).not_to include(*i18n_data_attributes.excluding(password_shown_announcement_text_key))
        end
      end

      context 'when the password hidden announcement text is customised' do
        let(:password_hidden_announcement_text_key) { "data-i18n.password-hidden-announcement" }
        let(:custom_password_hidden_announcement_text) { "The password has been obscured" }
        let(:kwargs) { { password_hidden_announcement_text: custom_password_hidden_announcement_text } }

        specify 'the hide button has the the corresponding i18n data attribute set' do
          hide_password_attr = parsed_subject.at_xpath(xpath_password_module_selector).attributes.fetch(password_hidden_announcement_text_key).value

          expect(hide_password_attr).to eql(custom_password_hidden_announcement_text)
        end

        specify 'no other i18n data attributes are set' do
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).to include(password_hidden_announcement_text_key)
          expect(parsed_subject.at_xpath(xpath_password_module_selector).attributes.keys).not_to include(*i18n_data_attributes.excluding(password_hidden_announcement_text_key))
        end
      end
    end

    describe 'setting autocomplete' do
      let(:kwargs) { { autocomplete: "cc-csc" } }

      specify 'sets the autocomplete value to the one provided' do
        expect(subject).to have_tag("input", with: { name: "person[password]", autocomplete: "cc-csc" })
      end
    end

    it_behaves_like 'a field that supports labels'
    it_behaves_like 'a field that supports labels as procs'
    it_behaves_like 'a field that supports captions on the label'
    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports hints' do
      let(:aria_described_by_target) { 'input' }
    end

    it_behaves_like 'a field that supports errors' do
      let(:object) { Person.new(photo: 'me.tiff') }
      let(:aria_described_by_target) { 'input' }

      let(:error_message) { /Password must be longer than 8 characters/ }
      let(:error_class) { 'govuk-password-input--error' }
      let(:error_identifier) { 'person-password-error' }
    end
  end
end
