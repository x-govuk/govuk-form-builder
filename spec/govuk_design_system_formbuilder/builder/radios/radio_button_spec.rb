describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'
  include_context 'setup radios'

  describe '#govuk_radio_button' do
    let(:method) { :govuk_radio_button }
    let(:value) { :ballpoint_pen }
    let(:value_with_dashes) { underscores_to_dashes(value) }
    let(:attribute) { :stationery }
    let(:args) { [method, attribute, value] }

    subject do
      builder.send(*args)
    end

    it_behaves_like 'a field that supports custom branding'

    specify 'output should contain a radio item group with a radio input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-radios__item' }) do
        with_tag('input', with: { type: 'radio', value: value })
      end
    end

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports labels' do
      let(:label_text) { 'Red' }
      let(:field_type) { 'input' }

      specify 'the label should have a radios label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-radios__label' })
      end
    end

    it_behaves_like 'a field that allows extra HTML attributes to be set' do
      let(:described_element) { 'input' }
      let(:value) { 'Montgomery Montgomery' }
      let(:expected_class) { 'govuk-radios__input' }
    end

    it_behaves_like 'a field that allows nested HTML attributes to be set' do
      let(:described_element) { 'input' }
      let(:expected_class) { 'govuk-radios__input' }
    end

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a fieldset item that can conditionally-reveal content' do
      subject do
        builder.send(*args) do
          builder.govuk_text_field(:stationery_choice)
        end
      end

      let(:fieldset_item_type) { 'radios' }
      let(:fieldset_item_type_single) { 'radio' }
    end

    context 'labels set via procs' do
      let(:label_text) { 'Orange' }
      let(:label_proc) { -> { label_text } }
      subject { builder.send(*args, label: label_proc) }

      specify 'the label should have a radio label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-radios__label' })
      end

      specify %(the label's for attribute should match the radio button's id) do
        label_for = parsed_subject.at_css('label')['for']
        radio_id = parsed_subject.at_css('input')['id']

        expect(label_for).to eql(radio_id)
      end
    end

    describe 'radio button hints' do
      subject do
        builder.govuk_radio_button(attribute, value, hint: { text: red_hint })
      end

      specify 'should contain a hint with the correct text' do
        expect(subject).to have_tag('span', text: red_hint)
      end

      specify 'the hint should have the correct classes' do
        expect(subject).to have_tag('span', with: { class: %w(govuk-hint govuk-radios__hint) })
      end

      context 'when the hint is supplied in a proc' do
        subject do
          builder.govuk_radio_button(attribute, value, hint: -> { builder.tag.section(red_hint) })
        end

        specify 'the proc-supplied hint content should be present and contained in a div' do
          expect(subject).to have_tag('div', with: { class: %w(govuk-hint govuk-radios__hint) }) do
            with_tag('section', text: red_hint)
          end
        end
      end
    end
  end
end
