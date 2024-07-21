describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_password_field' do
    let(:custom_label_text) { "What's your name?" }
    let(:method) { :govuk_label }
    let(:attribute) { :name }
    let(:args) { [method, attribute] }
    let(:kwargs) { { text: custom_label_text } }

    subject { builder.send(*args, **kwargs) }

    specify 'renders a label with the right custom text' do
      expect(subject).to have_tag('label', text: custom_label_text, with: { class: 'govuk-label' })
    end

    context 'when a caption is provided' do
      let(:kwargs) { { caption: { text: 'A very nice caption' } } }

      specify 'the caption is rendered inside the label' do
        expect(subject).to have_tag('label') do
          with_tag('span', with: { class: 'govuk-caption-m' }, text: 'A very nice caption')
        end
      end
    end

    describe 'sizes' do
      {
        's' => 'govuk-label--s',
        'm' => 'govuk-label--m',
        'l' => 'govuk-label--l',
        'xl' => 'govuk-label--xl'
      }.each do |size, expected_class|
        context "when size: '#{size}'" do
          let(:size) { size }
          let(:kwargs) { { size: } }

          subject { builder.send(*args, **kwargs) }

          specify "the label has class #{expected_class}" do
            expect(subject).to have_tag('label', with: { class: expected_class }, text: 'Name')
          end
        end
      end
    end

    context 'when hidden' do
      let(:kwargs) { { hidden: true } }

      specify 'the label is hidden' do
        expect(subject).to have_tag('label') do
          with_tag('span', with: { class: 'govuk-visually-hidden' }, text: 'Name')
        end
      end
    end

    context 'when tag overridden' do
      let(:kwargs) { { tag: 'h4' } }

      specify "the label is wrapped in the supplied element with class 'govuk-label-wrapper'" do
        expect(subject).to have_tag('h4', with: { class: 'govuk-label-wrapper' }) do
          with_tag('label', with: { class: 'govuk-label' }, text: 'Name')
        end
      end
    end

    context 'when extra arguments are supplied' do
      let(:kwargs) { { lang: 'de', data: { positive: 'yes' } } }

      specify 'the label is rendered with the extra HTML attributes present' do
        expect(subject).to have_tag('label', text: 'Name', with: { class: 'govuk-label', lang: 'de', 'data-positive' => 'yes' })
      end
    end
  end
end
