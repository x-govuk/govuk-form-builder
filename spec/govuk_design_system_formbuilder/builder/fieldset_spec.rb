describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_fieldset' do
    let(:method) { :govuk_fieldset }
    let(:legend_text) { 'Current address' }
    let(:inner_text) { 'Where do you live?' }

    subject do
      builder.send(method, legend: { text: legend_text }) do
        builder.tag.span(inner_text)
      end
    end

    specify 'output should be a fieldset containing the block contents' do
      expect(subject).to have_tag('fieldset', with: { class: 'govuk-fieldset' }) do |fs|
        expect(fs).to have_tag('legend', text: legend_text)
        expect(fs).to have_tag('span', text: inner_text)
      end
    end

    context 'with inner form elements' do
      subject do
        builder.send(method, legend: { text: legend_text }) do
          builder.govuk_text_field(:name)
        end
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
  end
end
