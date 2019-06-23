describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#submit' do
    let(:method) { :govuk_submit }
    subject { builder.send(method, 'Create') }

    specify 'output should be a form group containing a submit input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('input', with: { type: 'submit' })
      end
    end

    specify 'button should have the correct classes' do
      expect(subject).to have_tag('input', with: { class: 'govuk-button' })
    end
  end
end

