shared_examples 'a field that supports labels' do
  context 'when a label is provided' do
    subject { builder.send(*args, label: { text: label_text }) }

    specify 'the label should be included' do
      expect(subject).to have_tag('label', with: { class: 'govuk-label' }, text: label_text)
    end

    specify 'the label should be associated with the input' do
      input_name = parsed_subject.at_css(field_type)['id']
      label_for = parsed_subject.at_css('label')['for']
      expect(input_name).to eql(label_for)
    end

    context 'when the label is supplied with a wrapping tag' do
      let(:wrapping_tag) { 'h2' }
      subject { builder.send(*args, label: { text: label_text, tag: wrapping_tag }) }

      specify 'the label should be wrapped in by the wrapping tag' do
        expect(subject).to have_tag(wrapping_tag, with: { class: %w(govuk-label-wrapper) }) do |wt|
          expect(wt).to have_tag('label', text: label_text)
        end
      end
    end

    context 'hidden labels' do
      subject { builder.send(*args, label: { text: label_text, hidden: true }) }

      specify 'the label should be wrapped in a visually-hidden span' do
        expect(subject).to have_tag('label', text: label_text) do |label_element|
          expect(label_element).to have_tag('span', text: label_text, with: { class: 'govuk-visually-hidden' })
        end
      end
    end

    context 'label styling' do
      context 'font size overrides' do
        label_sizes = {
          'xl' => 'govuk-label--xl',
          'l'  => 'govuk-label--l',
          'm'  => 'govuk-label--m',
          's'  => 'govuk-label--s',
          nil  => nil
        }
        let(:label_sizes) { label_sizes }

        label_sizes.each do |size_name, size_class|
          context "#{size_name || 'no'} param" do
            let(:size_name) { size_name }
            let(:size_class) { size_class }
            subject { builder.send(*args, label: { size: size_name }) }

            if size_class.present?
              specify "should have extra class '#{size_class}'" do
                expect(extract_classes(parsed_subject, 'label')).to include(size_class)
              end
            else
              specify 'should have no extra size classes' do
                expect(extract_classes(parsed_subject, 'label') & label_sizes.values).to be_empty
              end
            end
          end
        end

        context 'when an invalid size is supplied' do
          let(:size) { 'extra-medium' }
          subject { builder.send(*args, label: { size: size }) }
          specify { expect { subject }.to raise_error("invalid size '#{size}', must be xl, l, m, s or nil") }
        end
      end
    end
  end

  context 'when no label is provided' do
    subject { builder.send(*args) }

    specify 'the label should have the default value' do
      expect(subject).to have_tag('label', with: { class: 'govuk-label' }, text: attribute.capitalize)
    end
  end
end
