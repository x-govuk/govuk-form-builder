shared_examples 'a field that supports captions' do
  let(:caption_text) { 'Stage 3' }
  let(:caption_class) { %(govuk-caption-#{caption_size}) }
  let(:caption_size) { 'l' }
  let(:caption_args) { { text: caption_text, size: caption_size } }

  subject { builder.send(*args, caption: caption_args, **caption_container) }

  describe 'inserting a caption' do
    specify 'should contain the caption' do
      expect(subject).to have_tag(caption_container_tag) do
        with_tag('span', text: caption_text, with: { class: caption_class })
      end
    end

    describe 'caption sizes' do
      %w(xl l m).each do |size|
        context %(when the caption size is #{size}) do
          let(:caption_size) { size }
          subject { builder.send(*args, **caption_container, caption: caption_args.merge(size: caption_size)) }

          specify "the caption should be size #{size}" do
            expect(subject).to have_tag('span', text: caption_text, with: { class: caption_class })
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
end

shared_examples 'a field that supports captions on the legend' do
  it_behaves_like 'a field that supports captions' do
    let(:caption_container_tag) { 'legend' }
    let(:caption_container) { { legend: { text: legend_text, tag: caption_container_tag } } }

    context 'when no legend is present but a caption is' do
      subject { builder.send(*args, caption: caption_args) }

      specify 'no caption should be rendered' do
        expect(subject).not_to have_tag('span', with: { class: caption_class })
      end
    end
  end
end

shared_examples 'a field that supports captions on the label' do
  it_behaves_like 'a field that supports captions' do
    let(:caption_container_tag) { 'label' }
    let(:caption_container) { { label: { text: label_text, size: 'm' } } }

    context 'when no label is present but a caption is' do
      # Unlike the legend, labels will fall back to their attribute name, so we
      # can only test against an empty label
      subject { builder.send(*args, label: { text: '' }, caption: caption_args) }

      specify 'no caption should be rendered' do
        expect(subject).not_to have_tag('span', with: { class: caption_class })
      end
    end
  end
end
