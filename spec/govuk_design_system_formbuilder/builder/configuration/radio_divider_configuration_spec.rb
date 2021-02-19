describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'radio divider config' do
    specify %(the default should be 'or') do
      expect(GOVUKDesignSystemFormBuilder.config.default_radio_divider_text).to eql('or')
    end

    context 'overriding with custom text' do
      let(:method) { :govuk_radio_divider }
      let(:args) { [method] }
      let(:default_radio_divider_text) { 'Actually, on the other hand' }

      subject { builder.send(*args) }

      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_radio_divider_text = default_radio_divider_text
        end
      end

      specify 'should use the default value when no override supplied' do
        expect(subject).to have_tag('div', text: default_radio_divider_text, with: { class: 'govuk-radios__divider' })
      end

      context %(overriding with 'Engage') do
        let(:radio_divider_text) { 'Alternatively' }
        let(:args) { [method, radio_divider_text] }

        subject { builder.send(*args) }

        specify 'should use supplied text when overridden' do
          expect(subject).to have_tag('div', text: radio_divider_text, with: { class: 'govuk-radios__divider' })
        end
      end
    end
  end
end
