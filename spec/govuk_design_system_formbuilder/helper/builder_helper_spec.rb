class Dummy
  include GOVUKDesignSystemFormBuilder::BuilderHelper
end

describe GOVUKDesignSystemFormBuilder::BuilderHelper, type: :helper do
  include_context 'setup examples'
  let(:object) { Person.new(name: 'Joey') }
  let(:object_name) { :person }
  let(:attribute) { :name }
  let(:args) { [object, :person, attribute] }
  let(:helper) { Dummy.new }

  describe '#govuk_design_system_formbuilder_field_id' do
    context %(given a person object's name attribute) do
      subject { helper.govuk_design_system_formbuilder_field_id(*args) }

      it { is_expected.to eql(%(#{object_name}-#{attribute}-field)) }

      context 'when the name is invalid' do
        let(:object) { Person.new }
        before { object.valid? }

        it { is_expected.to eql(%(#{object_name}-#{attribute}-field-error)) }
      end
    end

    describe %(given a person object's project attribute (multiple, identified by value)) do
      let(:attribute) { :projects }
      let(:value) { 123 }
      subject { helper.govuk_design_system_formbuilder_field_id(*args, value: value) }

      it { is_expected.to eql(%(#{object_name}-#{attribute}-#{value}-field)) }

      context 'when the project is invalid' do
        let(:object) { Person.new }
        before { object.valid? }

        context 'and link_errors is true (default)' do
          it { is_expected.to eql(%(#{object_name}-#{attribute}-field-error)) }
        end

        context 'and link_errors is false' do
          let(:kwargs) { { value: value, link_errors: false } }
          subject { helper.govuk_design_system_formbuilder_field_id(*args, **kwargs) }

          it { is_expected.to eql(%(#{object_name}-#{attribute}-#{value}-field)) }
        end
      end
    end
  end
end
