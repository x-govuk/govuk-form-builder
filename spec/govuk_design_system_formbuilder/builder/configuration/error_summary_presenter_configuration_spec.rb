class ErrorSummaryReversePresenter
  def initialize(error_messages)
    @error_messages = error_messages
  end

  def formatted_error_messages
    @error_messages.map { |attribute, messages| [attribute, messages.first.reverse] }
  end
end

describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe 'changing the default error order method' do
    let(:custom_presenter) { ErrorSummaryReversePresenter }
    let(:object) { Person.with_errors_on_base }
    let(:expected_error_message) { "This person is always invalid".reverse }
    subject { builder.govuk_error_summary }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_error_summary_presenter = custom_presenter
      end
    end

    specify "the error messages are in the format specified by the custom presenter" do
      expect(subject).to have_tag("li > a", href: "#person-base-field-error", text: expected_error_message)
    end
  end
end
