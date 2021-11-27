describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  let(:method) { :govuk_text_field }
  let(:attribute) { :hairstyle }
  let(:args) { [method, attribute] }

  subject { builder.send(*args) }

  # the hairstyle validation message contains a linebreak `<br/>` in it
  before { object.valid?(:trust_error_messages) }

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'trust error messages config' do
    let(:message_text) { parsed_subject.at_css('.govuk-error-message').text }

    specify 'displays the error message safely by default' do
      expect(subject).to have_tag('span', with: { class: 'govuk-error-message' }) do
        without_tag('br')
      end

      expect(message_text).to match(%r{<br/>})
    end

    context 'when error message content is trusted' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.trust_error_messages = true
        end
      end

      specify 'any markup in the string becomes HTML elements' do
        expect(subject).to have_tag('span', with: { class: 'govuk-error-message' }) do
          with_tag('br')
        end
      end
    end
  end
end
