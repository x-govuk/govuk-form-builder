shared_examples 'a field that supports setting the label caption via localisation' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

  context 'localising when no text is supplied' do
    let(:localisation_key) { attribute }

    let(:expected_caption) do
      I18n.translate(localisation_key, scope: 'helpers.caption.person')
    end

    subject { builder.send(*args) }

    specify 'should set the caption from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('span', text: expected_caption)
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_caption) { "Private data" }

    subject { builder.send(*args, caption: { text: expected_caption }) }

    specify 'should use the supplied caption text' do
      with_localisations(localisations) do
        expect(subject).to have_tag('span', text: expected_caption, with: { class: "govuk-caption-m" })
      end
    end
  end

  context 'allowing localised text to be suppressed' do
    let(:expected_caption) { "Private data" }

    subject do
      builder.send(*args, caption: nil)
    end

    specify 'no caption should be rendered' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('span', with: { class: "govuk-caption-m" })
      end
    end
  end

  context 'when the localised field is nested' do
    let(:value) { attribute_override }
    let(:attribute) { :number_and_street }

    subject do
      builder.fields_for(:address, builder: described_class) { |af| af.send(*args) }
    end

    let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

    let(:expected_text) do
      ao = defined?(attribute_override) ? attribute_override : "number_and_street"
      so = defined?(scope_override) ? scope_override : "helpers.caption.person.address"

      I18n.translate(ao, scope: so)
    end

    specify "finds the correct nested localisation" do
      with_localisations(localisations) do
        expect(subject).to have_tag("span", text: expected_text, with: { class: "govuk-caption-m" })
      end
    end
  end
end
