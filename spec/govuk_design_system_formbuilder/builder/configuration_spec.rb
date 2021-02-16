describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe 'configuration' do
    after { GOVUKDesignSystemFormBuilder.reset! }

    describe 'form validation' do
      let(:method) { :govuk_submit }
      let(:args) { Array.wrap(method) }
      subject { builder.send(*args) }

      context 'when default_form_novalidate is unset' do
        specify "submit input should have a formnovalidate attribute" do
          expect(subject).to have_tag('input', with: { type: 'submit', formnovalidate: 'formnovalidate' })
        end
      end

      context 'when default_form_novalidate is set to true' do
        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_form_novalidate = true
          end
        end

        specify "submit input should have no formnovalidate attribute" do
          expect(subject).to have_tag('input', with: { type: 'submit' })
          expect(parsed_subject.at_css('input').attributes.keys).not_to include("formnovalidate")
        end
      end
    end

    describe 'legend config' do
      include_context 'setup radios'
      let(:method) { :govuk_collection_radio_buttons }
      let(:colours) { Array.wrap(OpenStruct.new(id: 'red', name: 'Red')) }
      let(:args) { [method, attribute, colours, :id, :name] }
      let(:legend_text) { 'Choose a colour' }

      subject { builder.send(*args, legend: { text: legend_text }) }

      describe 'legend tag' do
        specify 'the default tag should be nil' do
          expect(GOVUKDesignSystemFormBuilder.config.default_legend_tag).to be_nil
        end

        context 'overriding with h6' do
          let(:configured_tag) { 'h6' }

          before do
            GOVUKDesignSystemFormBuilder.configure do |conf|
              conf.default_legend_tag = configured_tag
            end
          end

          specify 'should create a legend header wrapped in a h6 tag' do
            expect(subject).to have_tag(
              configured_tag,
              with: {
                class: 'govuk-fieldset__heading'
              },
              text: legend_text,
            )
          end
        end
      end

      describe 'legend size' do
        specify 'the default size should be m' do
          expect(GOVUKDesignSystemFormBuilder.config.default_legend_size).to eql('m')
        end

        context 'overriding with s' do
          let(:configured_size) { 's' }

          before do
            GOVUKDesignSystemFormBuilder.configure do |conf|
              conf.default_legend_size = configured_size
            end
          end

          specify 'should create a legend header with the small class' do
            expect(subject).to have_tag('fieldset') do
              with_tag('legend', with: { class: "govuk-fieldset__legend--#{configured_size}" })
            end
          end
        end
      end
    end

    describe 'submit config' do
      specify %(the default should be 'Continue') do
        expect(GOVUKDesignSystemFormBuilder.config.default_submit_button_text).to eql('Continue')
      end

      context 'overriding with custom text' do
        let(:method) { :govuk_submit }
        let(:args) { [method] }
        let(:default_submit_button_text) { 'Make it so, number one' }

        subject { builder.send(*args) }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_submit_button_text = default_submit_button_text
          end
        end

        specify 'should use the default value when no override supplied' do
          expect(subject).to have_tag('input', with: { type: 'submit', value: default_submit_button_text })
        end

        context %(overriding with 'Engage') do
          let(:submit_button_text) { 'Engage' }
          let(:args) { [method, submit_button_text] }

          subject { builder.send(*args) }

          specify 'should use supplied value when overridden' do
            expect(subject).to have_tag('input', with: { type: 'submit', value: submit_button_text })
          end
        end
      end
    end

    describe 'radio divider config' do
      specify %(the default should be 'or') do
        expect(GOVUKDesignSystemFormBuilder.config.default_radio_divider_text).to eql('or')
      end

      context 'overriding with custom text' do
        let(:method) { :govuk_radio_divider }
        let(:args) { [method] }
        let(:default_radio_divider_text) { 'Actually, on the other hand' }

        subject { builder.send(*args) }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_radio_divider_text = default_radio_divider_text
          end
        end

        specify 'should use the default value when no override supplied' do
          expect(subject).to have_tag('div', text: default_radio_divider_text, with: { class: 'govuk-radios__divider' })
        end

        context %(overriding with 'Engage') do
          let(:radio_divider_text) { 'Alternatively' }
          let(:args) { [method, radio_divider_text] }

          subject { builder.send(*args) }

          specify 'should use supplied text when overridden' do
            expect(subject).to have_tag('div', text: radio_divider_text, with: { class: 'govuk-radios__divider' })
          end
        end
      end
    end

    describe 'error summary title' do
      let(:method) { :govuk_error_summary }
      let(:args) { [method] }
      let(:default_error_summary_title) { 'Huge, huge problems here' }

      subject { builder.send(*args) }

      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_error_summary_title = default_error_summary_title
        end
      end

      before { object.valid? }

      specify 'should use the default value when no override supplied' do
        expect(subject).to have_tag('h2', text: default_error_summary_title, with: { class: 'govuk-error-summary__title' })
      end

      context %(overriding with 'Engage') do
        let(:error_summary_title) { %(We've been hit!) }
        let(:args) { [method, error_summary_title] }

        subject { builder.send(*args) }

        specify 'should use supplied text when overridden' do
          expect(subject).to have_tag('h2', text: error_summary_title, with: { class: 'govuk-error-summary__title' })
        end
      end
    end

    describe 'localisation configuration' do
      let(:args) { [method, attribute] }
      let(:attribute) { :name }
      let(:method) { :govuk_text_field }
      subject { builder.send(*args) }

      context 'with a custom fallback localisation schema root' do
        let(:localisations) { { en: YAML.load_file('spec/support/locales/custom_fallback.en.yaml') } }
        let(:label_text) { I18n.t(%i(my_shiny_new_app label widgets person name).join('.')) }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.localisation_schema_fallback = %i(my_shiny_new_app __context__ widgets)
          end
        end

        specify 'should use the configured localisation fallback schema' do
          with_localisations(localisations) do
            expect(subject).to have_tag('label', text: label_text)
          end
        end
      end

      context 'with custom contextual localisation schema roots' do
        let(:localisations) { { en: YAML.load_file('spec/support/locales/custom_contexts.en.yaml') } }

        context 'labels' do
          let(:label_text) { I18n.t(%i(a long convoluted schema nested_far_far label too_inconsistently person name).join('.')) }

          before do
            GOVUKDesignSystemFormBuilder.configure do |conf|
              conf.localisation_schema_label = %i(a long convoluted schema nested_far_far __context__ too_inconsistently)
              conf.localisation_schema_fallback = %i(unused)
            end
          end

          specify 'should use the configured localisation schema for labels' do
            with_localisations(localisations) do
              expect(subject).to have_tag('label', text: label_text)
            end
          end
        end

        context 'hints' do
          let(:hint_text) { I18n.t(%i(a long convoluted schema hint nested_far_too_deeply person name).join('.')) }

          before do
            GOVUKDesignSystemFormBuilder.configure do |conf|
              conf.localisation_schema_hint = %i(a long convoluted schema __context__ nested_far_too_deeply)
              conf.localisation_schema_fallback = %i(unused)
            end
          end

          specify 'should use the configured localisation schema for hints' do
            with_localisations(localisations) do
              expect(subject).to have_tag('span', text: hint_text, with: { class: 'govuk-hint' })
            end
          end
        end

        context 'legends' do
          let(:attribute) { :projects }
          let(:method) { :govuk_collection_check_boxes }
          let(:legend_text) { I18n.t(%i(a long convoluted schema legend nested_far_too_deeply person projects).join('.')) }

          subject { builder.send(method, attribute, projects, :id, :name) }

          before do
            GOVUKDesignSystemFormBuilder.configure do |conf|
              conf.localisation_schema_legend = %i(a long convoluted schema __context__ nested_far_too_deeply)
              conf.localisation_schema_fallback = %i(unused)
            end
          end

          specify 'should use the configured localisation schema for legends' do
            with_localisations(localisations) do
              expect(subject).to have_tag('legend', text: legend_text, with: { class: 'govuk-fieldset__legend' })
            end
          end
        end
      end
    end
  end
end
