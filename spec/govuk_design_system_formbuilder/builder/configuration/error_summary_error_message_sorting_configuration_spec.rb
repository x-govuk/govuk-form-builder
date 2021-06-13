describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe 'changing the default error order method' do
    let(:object) { OrderedErrorsWithCustomOrder.new }
    let(:custom_method_name) { :error_order }

    before { object.valid? }

    subject { builder.govuk_error_summary }

    let(:actual_order) { extract_field_names_from_errors_summary_list(parsed_subject) }
    let(:expected_order) { object.error_order.map(&:to_s) }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_error_summary_error_order_method = custom_method_name
      end
    end

    specify "the error messages are displayed in the order they were defined in the model" do
      expect(actual_order).to eql(expected_order)
    end
  end
end
