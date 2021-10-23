describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  before { object.valid? }
  subject { builder.govuk_error_summary }

  describe 'changing the defualt prefix' do
    let(:new_prefix) { 'turbo' }

    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_error_summary_turbo_prefix = new_prefix
      end
    end

    specify "there should be a data attribute matching the new prefix" do
      expect(subject).to have_tag('a', with: { "data-#{new_prefix}" => "false" }, count: object.errors.size)
    end
  end

  describe 'setting no prefix' do
    before do
      GOVUKDesignSystemFormBuilder.configure do |conf|
        conf.default_error_summary_turbo_prefix = nil
      end
    end

    specify 'there should be no data attribute present on the error links' do
      parsed_subject.css('a').map(&:attributes).each do |link_attrs|
        link_attrs.each_key do |link_attr|
          expect(link_attr).not_to start_with('data')
        end
      end
    end
  end
end
