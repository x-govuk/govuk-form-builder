describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'
  include_context 'setup radios'

  describe '#govuk_radio_button' do
    let(:method) { :govuk_radio_button }
    let(:value) { 'red' }
    let(:args) { [method, attribute, value] }

    subject { builder.send(*args) }

    specify 'output should contain a radio item group with a radio input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-radios__item' }) do |ri|
        expect(ri).to have_tag('input', with: { type: 'radio', value: value })
      end
    end

    it_behaves_like 'a field that supports labels' do
      let(:label_text) { 'Red' }
      let(:field_type) { 'input' }

      specify 'the label should have a radios label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-radios__label' })
      end
    end

    it_behaves_like 'a field that supports setting the label via localisation'

    context 'radio button hints' do
      subject do
        builder.govuk_radio_button(:favourite_colour, :red, hint_text: red_hint)
      end

      specify 'should contain a hint with the correct text' do
        expect(subject).to have_tag('span', text: red_hint)
      end

      specify 'the hint should have the correct classes' do
        expect(subject).to have_tag('span', with: { class: %w(govuk-hint govuk-radios__hint) })
      end
    end

    context 'conditionally revealing content' do
      context 'when a block is given' do
        subject do
          builder.govuk_radio_button(:favourite_colour, :red) do
            builder.govuk_text_field(:favourite_colour_reason)
          end
        end

        specify 'should place the conditional content at the same level as the radio button container' do
          expect(parsed_subject).to have_root_element_with_class('govuk-radios__conditional')
        end

        specify 'should include content provided in the block in a conditional div' do
          expect(subject).to have_tag('div', with: { class: 'govuk-radios__conditional govuk-radios__conditional--hidden' }) do |cd|
            expect(cd).to have_tag('label', with: { class: 'govuk-label' }, text: 'Favourite_colour_reason')
            expect(cd).to have_tag('input', with: { type: 'text' })
          end
        end

        specify "the data-aria-controls attribute should match the conditional block's id" do
          input_data_aria_controls = parsed_subject.at_css("input[type='radio']")['data-aria-controls']
          conditional_id = parsed_subject.at_css('div.govuk-radios__conditional')['id']
          expect(input_data_aria_controls).to eql(conditional_id)
        end

        specify 'conditional_id contains the object, attribute and value name' do
          expect(
            parsed_subject.at_css("input[type='radio']")['data-aria-controls']
          ).to eql('person-favourite-colour-red-conditional')
        end
      end

      context 'when no block is given' do
        subject { builder.govuk_radio_button(:favourite_colour, :red) }

        specify "the data-aria-controls attribute should be blank" do
          input_data_aria_controls = parsed_subject.at_css("input[type='radio']")['data-aria-controls']
          expect(input_data_aria_controls).to be_nil
        end

        specify "the conditional container should not be present" do
          expect(subject).not_to have_tag('.govuk-radios__conditional')
        end
      end
    end
  end
end
