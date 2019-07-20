shared_context 'setup builder' do
  # general builder objects
  let(:helper) { TestHelper.new }
  let(:object) { Person.new(name: 'Joey') }
  let(:object_name) { :person }
  let(:builder) { described_class.new(object_name, object, helper, {}) }
  let(:parsed_subject) { Nokogiri.parse(subject) }

  # collections for radio and check box specs
  let(:colours) do
    [
      OpenStruct.new(id: 'red', name: 'Red'),
      OpenStruct.new(id: 'blue', name: 'Blue'),
      OpenStruct.new(id: 'green', name: 'Green'),
      OpenStruct.new(id: 'yellow', name: 'Yellow')
    ]
  end

  let(:red_label) { 'Rosso' }
  let(:green_label) { 'Verde' }
  let(:red_hint) { 'Roses are red' }
  let(:blue_hint) { 'Violets are... purple?' }

  let(:project_x) { Project.new(id: 11, name: 'Project X', description: 'Xanthous, xylophone, xenon') }
  let(:project_y) { Project.new(id: 22, name: 'Project Y', description: 'Yellow, yoga, yacht') }
  let(:project_z) { Project.new(id: 33, name: 'Project Z', description: nil) }

  let(:projects) { [project_x, project_y, project_z] }
  let(:projects_with_descriptions) { projects.select { |p| p.description.present? } }
end
