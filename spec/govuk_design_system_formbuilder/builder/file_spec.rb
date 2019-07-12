describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_file_field' do
    let(:method) { :govuk_file_field }
    let(:attribute) { :photo }
    let(:label_text) { 'Upload certificate' }
    let(:hint_text) { 'Only PDFs are accepted' }

    subject do
      builder.send(method, attribute)
    end

    specify 'output should be a form group containing a file input and label' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        expect(subject).to have_tag('input', with: { type: 'file' })
        expect(subject).to have_tag('label')
      end
    end

    describe 'label' do
      context 'when a label is provided' do
        subject { builder.send(method, attribute, label: { text: label_text }) }

        specify 'the label should be included' do
          expect(subject).to have_tag('label', with: { class: 'govuk-label' }, text: label_text)
        end
      end

      context 'when no label is provided' do
        specify 'the label should have the default value' do
          expect(subject).to have_tag('label', with: { class: 'govuk-label' }, text: attribute.capitalize)
        end
      end

      context 'when the label is supplied with a wrapping tag' do
        let(:wrapping_tag) { 'h2' }
        subject { builder.send(method, attribute, label: { text: label_text, tag: wrapping_tag }) }

        specify 'the label should be wrapped in by the wrapping tag' do
          expect(subject).to have_tag(wrapping_tag, with: { class: %w(govuk-label-wrapper) }) do |wt|
            expect(wt).to have_tag('label', text: label_text)
          end
        end
      end
    end

    describe 'hint' do
      context 'when a hint is provided' do
        subject { builder.send(method, attribute, hint_text: hint_text) }

        specify 'the hint should be included' do
          expect(subject).to have_tag('span', with: { class: 'govuk-hint' }, text: hint_text)
        end
      end

      context 'when no hint is provided' do
        specify 'no hint should be included' do
          expect(subject).not_to have_tag('span', with: { class: 'govuk-hint' })
        end
      end
    end

    describe 'errors' do
      context 'when the attribute has errors' do
        let(:object) { Person.new(photo: 'me.tiff') }
        let(:error_identifier) { 'person-photo-error' }
        before { object.valid? }

        specify 'an error message should be displayed' do
          expect(subject).to have_tag('span', with: { class: 'govuk-error-message' }, text: /Must be a JPEG/)
        end

        specify 'the file upload element should have the correct error classes' do
          expect(subject).to have_tag('input', with: { class: 'govuk-file-upload--error' })
        end

        specify 'the error message should be associated with the file input' do
          expect(subject).to have_tag('input', with: { 'aria-describedby' => error_identifier })
          expect(subject).to have_tag('span', with: {
            class: 'govuk-error-message',
            id: error_identifier
          })
        end
      end

      context 'when the attribute has no errors' do
        let(:object) { Person.new(photo: 'me.jpeg') }

        specify 'no error messages should be displayed' do
          expect(subject).not_to have_tag('span', with: { class: 'govuk-error-message' })
        end
      end
    end

    describe 'additional attributes' do
      subject { builder.send(method, attribute, accept: 'image/*', multiple: true) }

      specify 'input should have additional attributes' do
        expect(subject).to have_tag('input', with: {
          accept: 'image/*',
          multiple: 'multiple'
        })
      end
    end
  end
end
