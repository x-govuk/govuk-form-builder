describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  let(:method) { :govuk_error_summary }

  describe 'changing the default error order method' do
    let(:object) { OrderedErrorsWithCustomOrderMethod.new }
    let(:custom_method_name) { :sort_my_errors_in_the_following_manner_please }
    let(:args) { [method] }

    let(:actual_order) { extract_field_names_from_errors_summary_list(parsed_subject) }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_error_summary_error_order_method = custom_method_name
      end
    end

    before { object.valid? }

    let(:expected_order) { %w(c e d a b) }

    subject { builder.send(*args) }

    specify "the error messages are displayed in the order they were defined in the model" do
      expect(actual_order).to eql(expected_order)
    end
  end
end
