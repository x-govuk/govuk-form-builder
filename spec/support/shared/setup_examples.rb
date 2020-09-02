shared_context 'setup examples' do
  let(:red_option) { OpenStruct.new(id: 'red', name: 'Red') }
  let(:blue_option) { OpenStruct.new(id: 'blue', name: 'Blue') }
  let(:green_option) { OpenStruct.new(id: 'green', name: 'Green') }
  let(:yellow_option) { OpenStruct.new(id: 'yellow', name: 'Yellow') }
  let(:colours) { [red_option, blue_option, green_option, yellow_option] }

  let(:red_label) { 'Rosso' }
  let(:green_label) { 'Verde' }
  let(:red_hint) { 'Roses are red' }
  let(:blue_hint) { 'Violets are... purple?' }

  let(:project_x) { Project.new(id: 11, name: 'Project X', description: 'Xanthous, xylophone, xenon') }
  let(:project_y) { Project.new(id: 22, name: 'Project Y', description: 'Yellow, yoga, yacht') }
  let(:project_z) { Project.new(id: 33, name: 'Project Z', description: nil) }

  let(:projects) { [project_x, project_y, project_z] }
  let(:projects_with_descriptions) { projects.select { |p| p.description.present? } }

  let(:department_it) { Department.new(code: :it, name: "Computers shenanigans") }
  let(:department_finance) { Department.new(code: :finance, name: "Monies") }
  let(:department_marketing) { Department.new(code: :marketing, name: "Flyer distribution") }
  let(:department_sales) { Department.new(code: :sales, name: "Selling stuff") }
  let(:departments) { [department_it, department_finance, department_marketing, department_sales] }
end
