shared_examples 'a field that supports errors' do
  context 'when the attribute has errors' do
    before { object.valid? }

    specify 'an error message should be displayed' do
      expect(subject).to have_tag('p', with: { class: 'govuk-error-message' }, text: error_message)
    end

    specify %(error has a hidden 'Error:' prefix) do
      expect(subject).to have_tag('span', with: { class: 'govuk-visually-hidden' }, text: 'Error: ')
    end

    context 'when the error message is localised' do
      let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

      specify %(error has a the overridden prefix) do
        with_localisations(localisations) do
          expect(subject).to have_tag('span', with: { class: 'govuk-visually-hidden' }, text: 'Oh dear: ')
        end
      end
    end

    specify 'the form group should have the correct error classes' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group--error' })
    end

    specify 'the field element should have the correct error classes' do
      if error_class.present?
        expect(subject).to have_tag(field_type, with: { class: error_class })
      end
    end

    specify 'the error message should be associated with the correct element' do
      expect(subject).to have_tag(aria_described_by_target, with: { 'aria-describedby' => error_identifier })
      expect(subject).to have_tag('p', with: {
        class: 'govuk-error-message',
        id: error_identifier
      })
    end

    context 'when there is more than one error' do
      let(:first_error) { "It is totally wrong" }
      let(:second_error) { "Very wrong indeed" }
      let(:error_messages) { [first_error, second_error] }

      before do
        object.errors.clear
        error_messages.each { |m| object.errors.add(attribute, m) }
      end

      specify 'the first error should be included' do
        expect(subject).to have_tag('p', text: Regexp.new(first_error))
      end

      specify 'the second error should not be included' do
        expect(subject).not_to have_tag('p', text: Regexp.new(second_error))
      end
    end
  end

  context 'when the attribute has no errors' do
    specify 'no error messages should be displayed' do
      expect(subject).not_to have_tag('p', with: { class: 'govuk-error-message' })
    end
  end

  context 'when the object does not support errors' do
    let(:object) { Guest.example }

    specify 'should correctly render the form group' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' })
    end

    specify 'no error should be raised' do
      expect { subject }.not_to raise_error
    end
  end
end
