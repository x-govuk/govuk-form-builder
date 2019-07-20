shared_context 'setup builder' do
  let(:helper) { TestHelper.new }
  let(:object) { Person.new(name: 'Joey') }
  let(:object_name) { :person }
  let(:builder) { described_class.new(object_name, object, helper, {}) }
  let(:parsed_subject) { Nokogiri.parse(subject) }
  let(:colours) do
    [
      OpenStruct.new(id: 'red', name: 'Red'),
      OpenStruct.new(id: 'blue', name: 'Blue'),
      OpenStruct.new(id: 'green', name: 'Green'),
      OpenStruct.new(id: 'yellow', name: 'Yellow')
    ]
  end
end
