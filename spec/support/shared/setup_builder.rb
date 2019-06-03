shared_context 'setup builder' do
  let(:helper) { TestHelper.new }
  let(:object) { Person.new }
  let(:object_name) { :person }
  let(:builder) { described_class.new(object_name, object, helper, {}) }
  let(:parsed_subject) { Nokogiri.parse(subject) }
end
