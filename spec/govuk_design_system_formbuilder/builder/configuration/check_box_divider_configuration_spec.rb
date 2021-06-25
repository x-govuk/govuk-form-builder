describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'checkbox divider config' do
    specify %(the default should be 'or') do
      expect(GOVUKDesignSystemFormBuilder.config.default_check_box_divider_text).to eql('or')
    end

    context 'overriding with custom text' do
      let(:method) { :govuk_check_box_divider }
      let(:args) { [method] }
      let(:default_check_box_divider_text) { 'Actually, how about' }

      subject { builder.send(*args) }

      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_check_box_divider_text = default_check_box_divider_text
        end
      end

      specify 'should use the default value when no override supplied' do
        expect(subject).to have_tag('div', text: default_check_box_divider_text, with: { class: 'govuk-checkboxes__divider' })
      end

      context %(overriding with 'Alternately') do
        let(:check_box_divider_text) { 'Alternately' }
        let(:args) { [method, check_box_divider_text] }

        subject { builder.send(*args) }

        specify 'should use supplied text when overridden' do
          expect(subject).to have_tag('div', text: check_box_divider_text, with: { class: 'govuk-checkboxes__divider' })
        end
      end
    end
  end
end
