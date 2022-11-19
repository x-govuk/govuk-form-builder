shared_examples 'a field that supports localised collection labels' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }
  let(:attribute) { :department }
  subject { builder.send(*args) }

  specify 'the labels should be set by localisation' do
    with_localisations(localisations) do
      departments.each do |department|
        expected_label = I18n.translate(department.code, scope: 'helpers.label.person.department_options')
        expect(subject).to have_tag('label', text: expected_label)
      end
    end
  end
end
