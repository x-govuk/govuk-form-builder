describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  subject { builder.send(*args) }

  # the hairstyle validation message contains a linebreak `<br/>` in it
  before { object.valid?(:trust_error_messages) }

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'trust error messages config for individual error messages' do
    let(:method) { :govuk_text_field }
    let(:attribute) { :hairstyle }
    let(:args) { [method, attribute] }
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

  describe 'trust error messages config for an error summary' do
    let(:method) { :govuk_error_summary }
    let(:args) { [method] }

    specify 'displays the error message safely by default' do
      expect(subject).to have_tag('ul', with: { class: %w(govuk-list govuk-error-summary__list) }) do
        expect(subject).to have_tag('a[href="#person-hairstyle-field-error"]') do
          without_tag('br')
        end
      end
    end

    context 'when error message content is trusted' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.trust_error_messages = true
        end
      end

      specify 'any markup in the string becomes HTML elements' do
        expect(subject).to have_tag('ul', with: { class: %w(govuk-list govuk-error-summary__list) }) do
          expect(subject).to have_tag('a[href="#person-hairstyle-field-error"]') do
            with_tag('br')
          end
        end
      end
    end
  end
end
