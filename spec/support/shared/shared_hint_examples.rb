shared_examples 'a field that supports hints' do
  context 'when a hint is provided as a string' do
    subject { builder.send(*args, hint: { text: hint_text }) }

    specify 'output should contain a hint' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        with_tag('div', text: hint_text, with: { class: 'govuk-hint' })
      end
    end

    specify 'output should also contain the label and field elements' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        ['label', field_type].each { |element| with_tag(element) }
      end
    end

    specify 'the hint should be associated with the input' do
      input_aria_describedby = parsed_subject.at_css(aria_described_by_target)['aria-describedby'].split
      hint_id = parsed_subject.at_css('div.govuk-hint')['id']
      expect(input_aria_describedby).to include(hint_id)
    end

    context 'when additional HTML attributes are provided' do
      let(:html_attributes) { { focusable: 'false', dir: 'rtl' } }
      subject { builder.send(*args, hint: { text: hint_text }.merge(html_attributes)) }

      specify 'the label should have the custom HTML attributes' do
        expect(subject).to have_tag('.govuk-hint', with: html_attributes, text: hint_text)
      end
    end
  end

  context 'when the hint is supplied as a proc' do
    let(:paragraph_1) { 'paragraph number one' }
    let(:paragraph_2) { 'paragraph number two' }

    let(:hint) do
      proc do
        builder.safe_join([builder.tag.p(paragraph_1), builder.tag.p(paragraph_2)])
      end
    end

    subject { builder.send(*args, hint: hint) }

    specify 'output should contain a hint' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        with_tag('div', with: { class: 'govuk-hint' })
      end
    end

    specify 'output should contain the content from the block' do
      expect(subject).to have_tag('div', with: { class: 'govuk-hint' }) do
        with_tag('p', text: paragraph_1)
        with_tag('p', text: paragraph_2)
      end
    end
  end

  context 'when a hint is provided as something other than a string or proc' do
    let(:some_array) { %w(a b c) }

    subject { builder.send(*args, hint: some_array) }

    specify 'should raise an error' do
      expect { subject }.to raise_error('hint must be a Proc or Hash')
    end
  end

  context 'when a hint is omitted with nil' do
    subject { builder.send(*args, hint: nil) }

    specify 'no hint should be present' do
      expect(subject).not_to have_tag('div', with: { class: 'govuk-hint' })
    end

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css(field_type)['aria-describedby']).not_to be_present
    end
  end

  context 'when a hint is not provided' do
    subject { builder.send(*args) }

    specify 'no hint should be present' do
      expect(subject).not_to have_tag('div', with: { class: 'govuk-hint' })
    end

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css(field_type)['aria-describedby']).not_to be_present
    end
  end
end
