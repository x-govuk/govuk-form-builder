shared_examples 'a field that supports setting the hint via localisation' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

  context 'localising when no text is supplied' do
    let(:expected_hint) do
      if defined?(value) && value.present?
        I18n.translate("helpers.hint.person.#{attribute}_options.#{value}")
      else
        I18n.translate("helpers.hint.person.#{attribute}")
      end
    end

    subject { builder.send(*args) { arbitrary_html_content } }

    specify 'should set the hint from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('div', text: expected_hint, with: { class: 'govuk-hint' })
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_hint) { "It's quite a straightforward question!" }

    subject do
      builder.send(*args, hint: { text: expected_hint }) { arbitrary_html_content }
    end

    specify 'should use the supplied hint text' do
      with_localisations(localisations) do
        expect(subject).to have_tag('div', text: expected_hint, with: { class: 'govuk-hint' })
      end
    end
  end

  context 'allowing localised text to be suppressed' do
    subject do
      builder.send(*args, hint: nil) { arbitrary_html_content }
    end

    specify 'no hint should be rendered' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('div', with: { class: 'govuk-hint' })
      end
    end
  end

  context 'when the localised field is nested' do
    let(:value) { attribute_override }
    let(:attribute) { :number_and_street }

    subject do
      builder.fields_for(:address, builder: described_class) { |af| af.send(*args) { arbitrary_html_content } }
    end

    let(:expected_text) do
      ao = defined?(attribute_override) ? attribute_override : "number_and_street"
      so = defined?(scope_override) ? scope_override : "helpers.hint.person.address"

      I18n.translate(ao, scope: so)
    end

    specify "finds the correct nested localisation" do
      with_localisations(localisations) do
        expect(subject).to have_tag("div", text: expected_text, with: { class: %w(govuk-hint) })
      end
    end
  end
end
