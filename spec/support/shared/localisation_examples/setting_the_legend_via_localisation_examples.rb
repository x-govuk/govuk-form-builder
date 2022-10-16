shared_examples 'a field that supports setting the legend via localisation' do
  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

  context 'localising when no text is supplied' do
    let(:expected_legend) { I18n.translate("helpers.legend.person.#{attribute}") }
    subject { builder.send(*args) { arbitrary_html_content } }

    specify 'should set the legend from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('fieldset') do
          with_tag('legend', text: Regexp.new(expected_legend), with: { class: 'govuk-fieldset__legend' })
        end
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_legend) { "It is quite a straightforward question!" }
    subject { builder.send(*args, legend: { text: expected_legend }) { arbitrary_html_content } }

    specify 'should set the legend from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('fieldset') do
          with_tag('legend', text: Regexp.new(expected_legend), with: { class: 'govuk-fieldset__legend' })
        end
      end
    end
  end

  context 'allowing localised text to be suppressed' do
    subject { builder.send(*args, legend: nil) { arbitrary_html_content } }

    specify 'no legend should be rendered' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('legend')
      end
    end
  end

  context 'when the localised field is nested' do
    let(:value) { attribute_override }
    let(:attribute) { :number_and_street }

    subject do
      builder.fields_for(:address, builder: described_class) { |af| af.send(*args) { arbitrary_html_content } }
    end

    let(:localisations) do
      { en: YAML.load_file('spec/support/locales/sample.en.yaml') }.tap do |h|
        h[:en]['helpers'].delete('caption')
      end
    end

    let(:expected_text) do
      ao = defined?(attribute_override) ? attribute_override : "number_and_street"
      so = defined?(scope_override) ? scope_override : "helpers.legend.person.address"

      I18n.translate(ao, scope: so)
    end

    specify "finds the correct nested localisation" do
      with_localisations(localisations) do
        expect(subject).to have_tag("legend", text: expected_text, with: { class: "govuk-fieldset__legend" })
      end
    end
  end
end
