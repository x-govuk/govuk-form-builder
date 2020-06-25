describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_fieldset' do
    let(:method) { :govuk_fieldset }
    let(:legend_text) { 'Current address' }
    let(:inner_text) { 'Where do you live?' }

    let(:legend_options) { { text: legend_text } }

    let(:example_block) { proc { builder.tag.span(inner_text) } }

    subject do
      builder.send(method, legend: legend_options, &example_block)
    end

    include_examples 'HTML formatting checks'

    specify 'output should be a fieldset containing the block contents' do
      expect(subject).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
        expect(fs).to have_tag('legend', text: legend_text)
        expect(fs).to have_tag('span', text: inner_text)
      end
    end

    context 'when the fieldset legend is configured' do
      let(:legend_options) { { text: legend_text, size: 'm', tag: 'h3', hidden: true } }

      specify 'output should have classes according to size and visibility' do
        expect(subject).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
          expect(fs).to have_tag('legend', with: { class: 'govuk-fieldset__legend--m govuk-visually-hidden' }) do |lg|
            expect(lg).to have_tag('h3', text: legend_text)
          end
        end
      end
    end

    context 'with inner form elements' do
      let(:example_block) { proc { builder.govuk_text_field(:name) } }

      subject do
        builder.send(method, legend: { text: legend_text }, &example_block)
      end

      specify 'inner inputs should be contained in the fieldset' do
        expect(subject).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
          expect(fs).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
            expect(fg).to have_tag('label')
            expect(fg).to have_tag('input')
          end
        end
      end
    end

    context 'when no block is supplied' do
      subject do
        builder.send(method, legend: { text: legend_text })
      end

      it { expect { subject }.to raise_error(LocalJumpError, /no block given/) }
    end

    context 'aria-describedby' do
      context 'when an array of nil values is supplied' do
        subject do
          builder.send(method, described_by: [nil, nil]) do
            builder.govuk_text_field(:name)
          end
        end

        specify 'the aria-describedby attribute should be absent' do
          expect(parsed_subject.at_css('fieldset').attributes).not_to include('aria-describedby')
        end
      end

      context 'when an array of element ids is supplied' do
        let(:element_id) { 'a-really-bad-error' }
        subject do
          builder.send(method, described_by: [element_id, nil]) do
            builder.govuk_text_field(:name)
          end
        end

        specify 'the aria-describedby attribute should contain the supplied element ids' do
          expect(subject).to have_tag('fieldset', with: { 'aria-describedby' => element_id })
        end
      end
    end

    context 'when a caption is supplied' do
      let(:caption_text) { 'Personal preferences' }
      let(:caption_size) { 'l' }
      let(:caption) { { text: caption_text, size: caption_size } }
      let(:caption_class) { "govuk-caption-#{caption_size}" }

      subject do
        builder.send(method, legend: legend, caption: caption, &example_block)
      end

      context 'with a legend' do
        let(:legend_text) { 'Favourite colour?' }
        let(:legend) { { text: legend_text } }

        specify 'output should contain a correclty-positioned caption with the right content' do
          expect(subject).to have_tag('fieldset', with: { class: %w(govuk-fieldset) }) do
            with_tag('span', text: caption_text, with: { class: caption_class })
          end
        end
      end

      context 'without a legend' do
        let(:legend) { {} }

        specify 'output should contain no caption at all' do
          expect(subject).not_to have_tag('span', with: { class: caption_class })
        end
      end
    end
  end
end
