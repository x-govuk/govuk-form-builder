shared_examples 'a field that supports hints' do
  context 'when a hint is provided' do
    subject { builder.send(*args, hint_text: hint_text) }

    specify 'output should contain a hint' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('span', text: hint_text, with: { class: 'govuk-hint' })
      end
    end

    specify 'output should also contain the label and field elements' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        ['label', field_type].each { |element| expect(fg).to have_tag(element) }
      end
    end

    specify 'the hint should be associated with the input' do
      input_aria_describedby = parsed_subject.at_css(aria_described_by_target)['aria-describedby'].split
      hint_id = parsed_subject.at_css('span.govuk-hint')['id']
      expect(input_aria_describedby).to include(hint_id)
    end
  end

  context 'when a hint is not provided' do
    subject { builder.send(*args) }

    specify 'no hint should be present' do
      expect(subject).not_to have_tag('span', with: { class: 'govuk-hint' })
    end

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css(field_type)['aria-describedby']).not_to be_present
    end
  end
end
