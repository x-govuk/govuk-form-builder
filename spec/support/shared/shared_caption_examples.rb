shared_examples 'a field that supports captions' do |captioned_element|
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

    context 'when additional HTML attributes are provided' do
      let(:html_attributes) { { focusable: 'false', dir: 'rtl' } }
      subject { builder.send(*args, **caption_container, caption: caption_args.merge(html_attributes)) }

      specify 'the label should have the custom HTML attributes' do
        expect(subject).to have_tag('span', with: { class: caption_class }.merge(html_attributes), text: caption_text)
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

      context 'when the caption size is not provided' do
        let(:caption_args) { { text: caption_text } }

        specify 'should use the default size' do
          expect(subject).to have_tag('span', text: caption_text, with: { class: 'govuk-caption-m' })
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

  describe %(presence depending on the #{captioned_element}) do
    context %(when the #{captioned_element} is nil) do
      subject { builder.send(*args, caption: caption_args, captioned_element => nil) }

      specify 'no caption is rendered' do
        expect(subject).not_to have_tag('span', with: { class: caption_class })
      end
    end

    context %(when the #{captioned_element} text is nil) do
      subject { builder.send(*args, caption: caption_args, captioned_element => { text: nil }) }

      # nil.presence is falsy so label will default to the attribute name so caption is rendered
      specify 'the caption is rendered' do
        expect(subject).to have_tag(captioned_element, with: { class: captioned_element_class })
        expect(subject).to have_tag('span', with: { class: caption_class })
      end
    end

    context %(when the #{captioned_element} text is an empty string) do
      subject { builder.send(*args, caption: caption_args, captioned_element => { text: '' }) }

      # ''.presence is also falsy so label will default to the attribute name so caption is rendered
      specify 'the caption is rendered' do
        expect(subject).to have_tag(captioned_element, with: { class: captioned_element_class })
        expect(subject).to have_tag('span', with: { class: caption_class })
      end
    end
  end
end

shared_examples 'a field that supports captions on the legend' do
  it_behaves_like('a field that supports captions', :legend) do
    let(:caption_container_tag) { 'legend' }
    let(:caption_container) { { legend: { text: legend_text, tag: caption_container_tag } } }
    let(:captioned_element_class) { 'govuk-fieldset__legend' }
  end
end

shared_examples 'a field that supports captions on the label' do
  it_behaves_like('a field that supports captions', :label) do
    let(:caption_container_tag) { 'label' }
    let(:caption_container) { { label: { text: label_text, size: 'm' } } }
    let(:captioned_element_class) { 'govuk-label' }
  end
end
