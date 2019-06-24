describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  let(:method) { :govuk_text_area }
  let(:attribute) { :cv }

  subject { builder.send(method, attribute) }

  specify 'should output a form group containing a textarea' do
    expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
      expect(fg).to have_tag('textarea')
    end
  end

  describe 'errors' do
    context 'when the attribute has errors' do
      specify 'an error message should be displayed'
      specify 'the textarea element should have the correct error classes'
    end

    context 'when the attribute has no errors' do
      specify 'no error messages should be displayed'
    end
  end

  describe 'label' do
    context 'when a label is provided' do
      specify 'the label should be included'
    end

    context 'when no label is provided' do
      specify 'the label should have the default value'
    end
  end

  describe 'hint' do
    context 'when a hint is provided' do
      specify 'the hint should be included'
    end

    context 'when no hint is provided' do
      specify 'no hint should be included'
    end
  end

  describe 'limits' do
    context 'max rows'
    context 'max chars'
    context 'max chars and max rows' do
      specify 'should raise an error'
    end
  end

  describe 'extra arguments' do
  end
end
