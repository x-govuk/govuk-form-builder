shared_examples 'a field that supports errors' do
  context 'when the attribute has errors' do
    before { object.valid? }

    specify 'an error message should be displayed' do
      expect(subject).to have_tag('span', with: { class: 'govuk-error-message' }, text: error_message)
    end

    specify 'the field element should have the correct error classes' do
      if error_class.present?
        expect(subject).to have_tag(field_type, with: { class: error_class })
      end
    end

    specify 'the error message should be associated with the correct element' do
      expect(subject).to have_tag(aria_described_by_target, with: { 'aria-describedby' => error_identifier })
      expect(subject).to have_tag('span', with: {
        class: 'govuk-error-message',
        id: error_identifier
      })
    end
  end

  context 'when the attribute has no errors' do
    specify 'no error messages should be displayed' do
      expect(subject).not_to have_tag('span', with: { class: 'govuk-error-message' })
    end
  end
end
