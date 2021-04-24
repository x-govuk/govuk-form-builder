describe GOVUKDesignSystemFormBuilder::FormBuilder do
  # this is intended to be a temporary measure that can be enabled
  # while projects are moving towards Rails-style dates, see #266
  # for more details.
  include_context 'setup builder'
  include_context 'setup examples'

  describe "invalid date config" do
    let(:wrong_date) { WrongDate.new(nil, nil, nil) }
    before { object.born_on = wrong_date }
    before { allow(Rails).to receive_message_chain(:logger, :warn) }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.enable_log_on_invalid_date = true
      end
    end

    subject! { builder.send(:govuk_date_field, :born_on) }

    specify "fails with an appropriate error message" do
      # three times, once per input
      expect(Rails.logger).to have_received(:warn).exactly(3).times.with(/invalid Date-like object/)
    end
  end
end
