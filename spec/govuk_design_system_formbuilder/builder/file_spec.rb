describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_file_field' do
    let(:method) { :govuk_file_field }
    let(:attribute) { :photo }
    let(:label_text) { 'Upload an image' }
    let(:hint_text) { 'Only JPEGs are accepted' }

    let(:args) { [method, attribute] }
    let(:field_type) { 'input' }
    subject { builder.send(*args) }

    specify 'output should be a form group containing a file input and label' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        expect(subject).to have_tag('input', with: { type: 'file' })
        expect(subject).to have_tag('label')
      end
    end

    it_behaves_like 'a field that supports labels'
    it_behaves_like 'a field that supports labels as procs'
    it_behaves_like 'a field that supports captions on the label'
    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'input' }
    end

    it_behaves_like 'a field that supports hints' do
      let(:aria_described_by_target) { 'input' }
    end

    it_behaves_like 'a field that supports errors' do
      let(:object) { Person.new(photo: 'me.tiff') }
      let(:aria_described_by_target) { 'input' }

      let(:error_message) { /Must be a JPEG/ }
      let(:error_class) { 'govuk-file-upload--error' }
      let(:error_identifier) { 'person-photo-error' }
    end

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { ['input', with: { type: 'file' }] }
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
