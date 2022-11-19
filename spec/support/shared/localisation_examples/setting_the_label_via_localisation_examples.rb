shared_examples 'a field that supports setting the label via localisation' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

  context 'localising when no text is supplied' do
    let(:localisation_key) do
      defined?(value) ? "#{attribute}_options.#{value}" : attribute
    end

    let(:expected_label) do
      I18n.translate(localisation_key, scope: 'helpers.label.person')
    end

    subject { builder.send(*args) }

    specify 'should set the label from the locales' do
      with_localisations(localisations) do
        # wrap label assertation in a regexp because the caption is placed alongside the text
        expect(subject).to have_tag('label', text: Regexp.new(expected_label))
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_label) { "Yeah but, who are you really?" }

    subject { builder.send(*args, label: { text: expected_label }) }

    specify 'should use the supplied label text' do
      with_localisations(localisations) do
        # wrap label assertation in a regexp because the caption is placed alongside the text
        expect(subject).to have_tag('label', text: Regexp.new(expected_label))
      end
    end
  end

  context 'allowing localised text to be suppressed' do
    subject do
      builder.send(*args, label: nil)
    end

    specify 'no label should be rendered' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('label')
      end
    end
  end

  context 'when the localised field is nested' do
    let(:value) { attribute_override }
    let(:attribute) { :number_and_street }

    subject do
      builder.fields_for(:address, builder: described_class) { |af| af.send(*args) }
    end

    let(:localisations) do
      # remove captions as they interfere with label content
      { en: YAML.load_file('spec/support/locales/sample.en.yaml') }.tap do |h|
        h[:en]['helpers'].delete('caption')
      end
    end

    let(:expected_text) do
      ao = defined?(attribute_override) ? attribute_override : "number_and_street"
      so = defined?(scope_override) ? scope_override : "helpers.label.person.address"

      I18n.translate(ao, scope: so)
    end

    specify "finds the correct nested localisation" do
      with_localisations(localisations) do
        expect(subject).to have_tag("label", text: expected_text, with: { class: "govuk-label" })
      end
    end
  end
end
