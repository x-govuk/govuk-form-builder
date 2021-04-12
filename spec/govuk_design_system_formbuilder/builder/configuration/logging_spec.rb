describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  before { object.born_on = { not_a_date: true } }
  before { allow(Rails).to receive_message_chain(:logger, :warn) }
  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'logging config' do
    context 'when logging is enabled (default)' do
      subject! { builder.send(:govuk_date_field, :born_on) }

      specify "Rails logger is called" do
        expect(Rails.logger).to have_received(:warn).at_least(1).times
      end
    end

    context 'when logging is disabled' do
      before { GOVUKDesignSystemFormBuilder.configure { |conf| conf.enable_logger = false } }
      subject! { builder.send(:govuk_date_field, :born_on) }

      specify "Rails logger is called" do
        expect(Rails.logger).not_to have_received(:warn)
      end
    end
  end
end
