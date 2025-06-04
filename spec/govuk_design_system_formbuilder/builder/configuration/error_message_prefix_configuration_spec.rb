describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }
  describe 'error message prefix' do
    let(:default_error_message_prefix) { 'Error' }
    let(:method) { :govuk_text_field }
    let(:attribute) { :favourite_colour }
    let(:args) { [method, attribute] }

    subject { builder.send(*args) }

    before { object.valid? }

    specify 'should use the default value when no override supplied' do
      expect(subject).to have_tag('div', class: 'govuk-form-group') do
        with_tag('span', text: "Error: ", with: { class: 'govuk-visually-hidden' })
      end
    end

    context %(overriding with custom text) do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_error_message_prefix = 'Dang'
        end
      end

      subject { builder.send(*args) }

      specify 'should use supplied text when overridden' do
        expect(subject).to have_tag('div', class: 'govuk-form-group') do
          with_tag('span', text: "Dang: ", with: { class: 'govuk-visually-hidden' })
        end
      end
    end
  end
end
