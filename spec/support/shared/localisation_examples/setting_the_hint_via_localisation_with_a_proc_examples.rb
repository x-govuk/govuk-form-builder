shared_examples 'a field that allows the hint to be localised via a proc' do
  let(:locale) { :de }
  let(:localisations) { YAML.load_file('spec/support/locales/colours.de.yaml') }

  context 'localising collection items using procs' do
    subject { builder.send(*args) }

    specify 'hints should be present and correctly-localised' do
      with_localisations({ locale => localisations }, locale:) do
        colours.each do |c|
          expect(subject).to have_tag(
            'div',
            text: localisations.dig("colours", c.name.downcase),
            with: { class: 'govuk-hint' }
          )
        end
      end
    end
  end
end
