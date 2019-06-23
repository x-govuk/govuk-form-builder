describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#date_input_group' do
    let(:method) { :govuk_date_field }
    let(:attribute) { :born_on }
    let(:fieldset_heading) { 'Date of birth' }
    let(:hint_text) { 'It says it on your birth certificate' }

    subject { builder.send(method, attribute) }

    specify 'should output a form group with fieldset, date group and 3 inputs and labels' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('div', with: { class: 'govuk-fieldset'}) do |fs|
          expect(fs).to have_tag('div', with: { class: 'govuk-date-input' }) do |di|
            expect(di).to have_tag('input', with: { type: 'number' }, count: 3)
            expect(di).to have_tag('label', count: 3)
          end
        end
      end
    end

    specify 'inputs should have the correct labels'
    specify 'inputs should have the min and max'
    specify 'inputs should have the correct classes'
    specify 'inputs should have the width class'
    specify 'labels should be associated with inputs'

    context 'legend' do
      context 'when a legend is supplied' do
        specify 'legend tag should be present and have the correct contents'
      end

      context 'when no legend is supplied' do
        specify 'legend tag should not be present'
      end
    end

    context 'hint' do
      specify 'hint should be present'
    end

    context 'default values' do
      specify 'should be set when present on the object'
    end
  end
end
