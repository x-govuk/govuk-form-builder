class Dummy
  include GOVUKDesignSystemFormBuilder::BuilderHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  attr_accessor :output_buffer

  def initialize
    @output_buffer = ActionView::OutputBuffer.new
  end
end

describe GOVUKDesignSystemFormBuilder::BuilderHelper, type: :helper do
  include_context 'setup examples'
  let(:object) { Person.new(name: 'Joey') }
  let(:object_name) { :person }
  let(:attribute) { :name }
  let(:args) { [object, attribute, :person] }
  let(:helper) { Dummy.new }

  describe '#govuk_field_id' do
    context %(given a person object's name attribute) do
      subject { helper.govuk_field_id(*args) }

      it { is_expected.to eql(%(#{object_name}-#{attribute}-field)) }

      context 'when the name is invalid' do
        let(:object) { Person.new }
        before { object.valid? }

        specify "the id is built using the object name and attribute" do
          expect(subject).to eql(%(#{object_name}-#{attribute}-field-error))
        end
      end

      context 'when no object_name is provided' do
        let(:args) { [object, attribute] }
        subject { helper.govuk_field_id(*args) }

        specify "the object name is inferred from the object" do
          expect(subject).to eql(%(#{object_name}-#{attribute}-field))
        end
      end
    end

    describe %(given a person object's project attribute (multiple, identified by value)) do
      let(:attribute) { :projects }
      let(:value) { 123 }
      subject { helper.govuk_field_id(*args, value:) }

      specify "the id is built using the object name, attribute and value" do
        expect(subject).to eql(%(#{object_name}-#{attribute}-#{value}-field))
      end

      context 'when the project is invalid' do
        let(:object) { Person.new }
        before { object.valid? }

        context 'and link_errors is true (default)' do
          specify "the id is built using the object name, attribute, value and error status" do
            expect(subject).to eql(%(#{object_name}-#{attribute}-field-error))
          end
        end

        context 'and link_errors is false' do
          let(:kwargs) { { value:, link_errors: false } }
          subject { helper.govuk_field_id(*args, **kwargs) }

          specify "does not include the error status in the generated id" do
            expect(subject).to eql(%(#{object_name}-#{attribute}-#{value}-field))
          end
        end
      end
    end
  end

  describe '#govuk_error_summary' do
    let(:kwargs) { {} }
    let(:args) { [object, object_name] }
    before { object.valid? }

    subject { helper.govuk_error_summary(*args, **kwargs) }

    it { is_expected.to render_an_error_summary.with(object.errors.size).errors }

    context 'when extra arguments are provided' do
      let(:custom_title) { "Something went terribly wrong" }
      let(:custom_class) { "pink-stripes" }
      let(:args) { [object, object_name, custom_title] }
      let(:kwargs) { { class: custom_class } }

      specify "the custom title is set" do
        expect(subject).to have_tag("h2", text: custom_title, with: { class: "govuk-error-summary__title" })
      end

      specify "the custom class is present" do
        expect(subject).to have_tag("div", with: { class: [custom_class, "govuk-error-summary"] })
      end
    end

    context 'when no object_name is provided' do
      let(:args) { [object] }
      subject { helper.govuk_error_summary(*args) }

      specify "the object name is inferred from the object" do
        is_expected.to render_an_error_summary.with(object.errors.size).errors
      end
    end

    context 'when a block is provided' do
      let(:custom_content_text) { "Fix the things below" }

      subject do
        helper.govuk_error_summary(*args) do
          custom_content_text
        end
      end

      specify "the custom content should be present in the error summary" do
        expect(subject).to have_tag("div", with: { class: "govuk-error-summary" }) do
          with_tag("div", with: { class: "govuk-error-summary__body" }, text: Regexp.new(custom_content_text))
        end
      end
    end
  end
end
