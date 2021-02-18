describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'submit config' do
    specify %(the default should be 'Continue') do
      expect(GOVUKDesignSystemFormBuilder.config.default_submit_button_text).to eql('Continue')
    end

    context 'overriding with custom text' do
      let(:method) { :govuk_submit }
      let(:args) { [method] }
      let(:default_submit_button_text) { 'Make it so, number one' }

      subject { builder.send(*args) }

      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_submit_button_text = default_submit_button_text
        end
      end

      specify 'should use the default value when no override supplied' do
        expect(subject).to have_tag('input', with: { type: 'submit', value: default_submit_button_text })
      end

      context %(overriding with 'Engage') do
        let(:submit_button_text) { 'Engage' }
        let(:args) { [method, submit_button_text] }

        subject { builder.send(*args) }

        specify 'should use supplied value when overridden' do
          expect(subject).to have_tag('input', with: { type: 'submit', value: submit_button_text })
        end
      end
    end
  end
end
