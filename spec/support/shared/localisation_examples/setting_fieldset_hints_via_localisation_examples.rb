shared_examples 'a field that supports localised fieldset hints' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/collection_hints.en.yaml').deep_symbolize_keys } }
  let(:expected_hints) { localisations.dig(:en, :helpers, :hint, :person, localisation_key) }

  specify 'the hints should be set by localisation' do
    with_localisations(localisations) do
      expected_hints.each do |id, hint|
        expected_id = ["person", field_name_selector, id, "hint"].join("-")
        expect(subject).to have_tag("div", with: { id: expected_id }, text: hint)
      end
    end
  end
end
