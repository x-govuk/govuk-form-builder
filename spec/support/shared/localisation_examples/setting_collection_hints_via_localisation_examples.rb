shared_examples 'a field that supports localised collection hints' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }
  let(:attribute) { :department }
  subject { builder.send(*args) }

  specify 'the hints should be set by localisation' do
    with_localisations(localisations) do
      departments.each do |department|
        expected_hint = I18n.translate(department.code, scope: 'helpers.hint.person.department_options', default: nil)

        if expected_hint.present?
          expect(subject).to have_tag('div', with: { class: %w(govuk-hint).append(hint_class) }, text: expected_hint)
        end
      end

      # testing that the correct hint (sales) is missing is a bit 'involved',
      # so now we've ensured that the ones we expect to be there are present
      # let's make sure they're the only ones that are by counting them
      departments_with_localised_hints = departments.count do |department|
        I18n.translate(department.code, scope: 'helpers.hint.person.department_options', default: nil)
      end

      expect(subject).to have_tag('div', with: { class: %w(govuk-hint).append(hint_class) }, count: departments_with_localised_hints)
    end
  end
end
