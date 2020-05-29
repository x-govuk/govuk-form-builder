shared_examples 'a field that supports a fieldset with legend' do
  context 'when a legend is supplied' do
    context 'when text is supplied' do
      subject { builder.send(*args, legend: { text: legend_text }) }

      specify 'legend tag should be present' do
        expect(subject).to have_tag('legend')
      end
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
          expect { subject }.to raise_error("invalid size '#{size}', must be xl, l, m, s")
        end
      end
    end

    context 'captions' do
      let(:legend_header_tag) { 'h3' }
      let(:caption_args) { { text: caption_text, size: caption_size } }
      subject { builder.send(*args, legend: { text: legend_text, tag: legend_header_tag, caption: caption_args }) }

      context 'when a legend and caption are present' do
        let(:caption_text) { 'Stage 3' }

        describe 'inserting a caption' do
          let(:caption_size) { 'l' }
          specify 'should contain the caption' do
            expect(subject).to have_tag(legend_header_tag) do
              with_tag('span', text: caption_text, with: { class: "govuk-caption-#{caption_size}" })
            end
          end
        end

        %w(xl l m).each do |size|
          context %(when the caption size is #{size}) do
            let(:caption_size) { size }
            subject { builder.send(*args, legend: { text: legend_text, tag: legend_header_tag, caption: caption_args.merge(size: caption_size) }) }

            specify "the caption should be size #{size}" do
              expect(subject).to have_tag('span', text: caption_text, with: { class: "govuk-caption-#{caption_size}" })
            end
          end
        end

        context 'when the caption size is invalid' do
          let(:caption_size) { 'super-xxxl' }

          specify 'should fail with an appropriate error message' do
            expect { subject }.to raise_error(ArgumentError, %(invalid size '#{caption_size}', must be xl, l or m))
          end
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
