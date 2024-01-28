shared_examples 'a field that allows the label to be localised via a proc' do
  let(:locale) { :de }
  let(:localisations) { YAML.load_file('spec/support/locales/colours.de.yaml') }

  context 'localising collection items using procs' do
    subject { builder.send(*args) }

    specify 'labels should be present and correctly-localised' do
      with_localisations({ locale => localisations }, locale:) do
        colours.each do |c|
          expect(subject).to have_tag(
            'label',
            text: localisations.dig("colours", c.name.downcase),
            with: { class: 'govuk-label' }
          )
        end
      end
    end
  end
end
