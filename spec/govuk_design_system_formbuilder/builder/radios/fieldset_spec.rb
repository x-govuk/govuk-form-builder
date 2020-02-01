describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'
  include_context 'setup radios'

  describe '#govuk_radio_buttons_fieldset' do
    let(:method) { :govuk_radio_buttons_fieldset }
    let(:args) { [method, attribute] }

    subject do
      builder.send(*args) do
        builder.safe_join(
          [
            builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }),
            builder.govuk_radio_button(:favourite_colour, :green, label: { text: green_label })
          ]
        )
      end
    end

    context 'when no block is supplied' do
      subject { builder.send(*args) }
      specify { expect { subject }.to raise_error(NoMethodError, /undefined method.*call/) }
    end

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-favourite-colour-error' }
    end

    it_behaves_like 'a field that supports setting the hint via localisation'
    it_behaves_like 'a field that supports setting the legend via localisation'

    it_behaves_like 'a field that accepts a plain ruby object' do
      subject { builder.send(*args) {} }

      let(:described_element) { 'fieldset' }
    end

    context 'when a block containing radio buttons is supplied' do
      let(:example_block) do
        proc { builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }) }
      end

      specify 'output should be a form group containing a form group and fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' })
        end
      end

      specify 'output should contain radio buttons' do
        expect(subject).to have_tag('div', with: { class: 'govuk-radios', 'data-module' => 'govuk-radios' }) do
          expect(subject).to have_tag('input', with: { type: 'radio' }, count: 2)
        end
      end

      context 'layout direction' do
        context 'when inline is specified in the options' do
          subject { builder.send(*args, inline: true, &example_block) }

          specify "should have the additional class 'govuk-radios--inline'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--inline) })
          end
        end

        context 'when inline is not specified in the options' do
          subject { builder.send(*args, &example_block) }

          specify "should have no additional classes" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'radio button size' do
        context 'when small is specified in the options' do
          subject { builder.send(*args, small: true, &example_block) }

          specify "should have the additional class 'govuk-radios--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject { builder.send(*args, &example_block) }

          specify "should not have the additional class 'govuk-radios--small'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'radio button classes' do
        context 'when extra css classes are specified in the options' do
          subject { builder.send(*args, classes: 'foo', &example_block) }

          specify "should have the additional class 'foo'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios foo) })
          end
        end
      end

      context 'dividers' do
        subject do
          builder.send(*args) do
            builder.govuk_radio_divider
          end
        end

        specify "should output a 'or' divider by default" do
          expect(subject).to have_tag('div', text: 'or', with: { class: %w(govuk-radios__divider) })
        end

        context 'when divider text overridden' do
          let(:other_text) { 'alternatively' }
          subject do
            builder.send(method, attribute) do
              builder.govuk_radio_divider(other_text)
            end
          end

          specify "should output a divider containing the supplied text" do
            expect(subject).to have_tag('div', text: other_text, with: { class: %w(govuk-radios__divider) })
          end
        end
      end
    end

    context 'with hint_text' do
      subject do
        builder.send(*args) do
          builder.safe_join(
            [
              builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }, hint_text: 'red'),
              builder.govuk_radio_button(:favourite_colour, :green, label: { text: green_label }, hint_text: 'green')
            ]
          )
        end
      end

      specify 'the hint should be associated with the correct radio button' do
        %i[red green].each do |value|
          hint_id = "person-favourite-colour-#{value}-hint"
          expect(subject).to have_tag('input', with: { "aria-describedby" => hint_id })
          expect(subject).to have_tag('span', with: { class: 'govuk-hint', id: hint_id })
        end
      end
    end
  end
end
