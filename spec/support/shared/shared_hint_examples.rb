shared_examples 'a field that supports hints' do
  context 'when a hint is provided as a string' do
    subject { builder.send(*args, hint: { text: hint_text }) }

    specify 'output should contain a hint in a span tag' do
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

    context 'extra attributes' do
      let(:component_id) { 'xyz' }
      let(:dir) { 'rtl' }

      subject { builder.send(*args, hint: { text: hint_text, dir: dir, data: { component: component_id } }) }

      specify 'the custom attributes should be set on the hint' do
        expect(subject).to have_tag('span', with: { class: 'govuk-hint', 'data-component': component_id, dir: dir })
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

    specify 'output should contain a hint in a div tag' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('div', with: { class: 'govuk-hint' })
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
      expect(subject).not_to have_tag('span', with: { class: 'govuk-hint' })
    end

    specify 'output should have no empty aria-describedby attribute' do
      expect(parsed_subject.at_css(field_type)['aria-describedby']).not_to be_present
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
