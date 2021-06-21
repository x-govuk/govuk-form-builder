describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'submit config' do
    let(:method) { :govuk_submit }
    let(:args) { [method] }
    let(:kwargs) { {} }
    subject { builder.send(*args, **kwargs) }

    describe 'button text' do
      specify %(the default should be 'Continue') do
        expect(GOVUKDesignSystemFormBuilder.config.default_submit_button_text).to eql('Continue')
      end

      context 'setting a new default' do
        let(:default_submit_button_text) { 'Make it so, number one' }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_submit_button_text = default_submit_button_text
          end
        end

        specify 'should use the default value when no override supplied' do
          expect(subject).to have_tag('button', with: { type: 'submit' }, text: default_submit_button_text)
        end

        context %(overriding with 'Engage') do
          let(:submit_button_text) { 'Engage' }
          let(:args) { [method, submit_button_text] }

          specify 'should use supplied value when overridden' do
            expect(subject).to have_tag('button', with: { type: 'submit' }, text: submit_button_text)
          end
        end
      end
    end

    describe 'validation' do
      # NOTE:
      #  `validate: false` = formnovalidate attribute present
      #  `validate: true`  = formnovalidate attribute absent
      specify %(the default should be false) do
        expect(GOVUKDesignSystemFormBuilder.config.default_submit_validate).to be(false)
      end

      context 'setting the default to true' do
        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.default_submit_validate = true
          end
        end

        specify 'should have no formnovalidate attribute' do
          expect(parsed_subject.at_css('button').attributes.keys).not_to include('formnovalidate')
        end

        context %(overriding with false) do
          let(:kwargs) { { validate: false } }

          specify 'should have a formnovalidate attribute' do
            expect(subject).to have_tag('button', with: { type: 'submit', formnovalidate: 'formnovalidate' })
          end
        end
      end
    end
  end
end
