describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }
  describe 'error summary title' do
    let(:method) { :govuk_error_summary }
    let(:args) { [method] }
    let(:default_error_summary_title) { 'Huge, huge problems here' }

    subject { builder.send(*args) }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_error_summary_title = default_error_summary_title
      end
    end

    before { object.valid? }

    specify 'should use the default value when no override supplied' do
      expect(subject).to have_tag('h2', text: default_error_summary_title, with: { class: 'govuk-error-summary__title' })
    end

    context %(overriding with 'Engage') do
      let(:error_summary_title) { %(We've been hit!) }
      let(:args) { [method, error_summary_title] }

      subject { builder.send(*args) }

      specify 'should use supplied text when overridden' do
        expect(subject).to have_tag('h2', text: error_summary_title, with: { class: 'govuk-error-summary__title' })
      end
    end
  end
end
