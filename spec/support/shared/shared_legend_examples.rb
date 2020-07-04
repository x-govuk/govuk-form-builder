shared_examples 'a field that supports a fieldset with legend' do
  context 'when a legend is supplied' do
    context 'when text is supplied' do
      subject { builder.send(*args, legend: { text: legend_text }) }

      specify 'legend tag should be present' do
        expect(subject).to have_tag('legend')
      end
    end

    context 'when something other than a Proc or Hash is supplied' do
      subject { builder.send(*args, legend: "This should fail") }

      specify { expect { subject }.to raise_error(ArgumentError, 'legend must be a Proc or Hash') }
    end

    context 'when no text is supplied' do
      subject { builder.send(*args, legend: { text: nil }) }

      specify 'output should not contain a header' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
            expect(fs).not_to have_tag('h1')
          end
        end
      end
    end

    context 'when text is supplied with a custom tag' do
      let(:tag) { 'h4' }
      subject { builder.send(*args, legend: { text: legend_text, tag: tag }) }

      specify 'output fieldset should contain the specified tag' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
            expect(fs).to have_tag(tag, text: legend_text)
          end
        end
      end
    end

    context 'when text is supplied with a custom size' do
      context 'with a valid size' do
        let(:size) { 'm' }
        subject { builder.send(*args, legend: { text: legend_text, size: size }) }

        specify 'output fieldset should contain the specified tag' do
          expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
            expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
              expect(fs).to have_tag('h1', text: legend_text, class: "govuk-fieldset__legend--#{size}")
            end
          end
        end
      end

      context 'with an invalid size' do
        let(:size) { 'extra-medium' }
        subject { builder.send(*args, legend: { text: legend_text, size: size }) }

        specify 'should raise an error' do
          expect { subject }.to raise_error("invalid size '#{size}', must be xl, l, m or s")
        end
      end
    end

    context 'when a proc is supplied' do
      let(:caption_classes) { %w(govuk-caption-m) }
      let(:heading_classes) { %w(govuk-heading-l) }
      let(:caption) { %(Caption from the proc) }
      let(:heading) { %(Heading from the proc) }

      let(:legend) do
        proc do
          builder.safe_join(
            [
              builder.tag.span(caption, class: caption_classes),
              builder.tag.h1(heading, class: heading_classes)
            ]
          )
        end
      end

      subject { builder.send(*args, legend: legend) }

      specify 'output fieldset should contain the specified tag' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
            expect(fs).to have_tag('span', class: caption_classes, text: caption)
            expect(fs).to have_tag('h1', class: heading_classes, text: heading)
          end
        end
      end
    end
  end

  context 'when no legend is supplied' do
    specify 'legend tag should not be present' do
      expect(subject).not_to have_tag('legend')
    end
  end
end
