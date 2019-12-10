LOCALISATIONS = {
  en: YAML.load_file('spec/support/locales/sample.en.yaml')
}.freeze

shared_examples 'a field that supports setting the label via localisation' do
  let(:localisations) { LOCALISATIONS }

  context 'localising when no text is supplied' do
    let(:expected_label) { I18n.translate("helpers.label.person.#{attribute}") }
    subject { builder.send(*args) }

    specify 'should set the label from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('label', text: expected_label)
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_label) { "Yeah but, who are you really?" }

    subject { builder.send(*args.push(label: { text: expected_label })) }

    specify 'should use the supplied label text' do
      with_localisations(localisations) do
        expect(subject).to have_tag('label', text: expected_label)
      end
    end
  end
end

shared_examples 'a field that supports setting the hint via localisation' do
  let(:arbitrary_html_content) { builder.tag.p("a wild paragraph has appeared") }
  let(:localisations) { LOCALISATIONS }

  context 'localising when no text is supplied' do
    let(:expected_hint) { I18n.translate("helpers.hint.person.#{attribute}") }

    subject { builder.send(*args) { arbitrary_html_content } }

    specify 'should set the hint from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('span', text: expected_hint, with: { class: 'govuk-hint' })
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_hint) { "It's quite a straightforward question!" }

    subject do
      builder.send(*args.push(hint_text: expected_hint)) { arbitrary_html_content }
    end

    specify 'should use the supplied hint text' do
      with_localisations(localisations) do
        expect(subject).to have_tag('span', text: expected_hint, with: { class: 'govuk-hint' })
      end
    end
  end
end

shared_examples 'a field that supports setting the legend via localisation' do
  let(:arbitrary_html_content) { builder.tag.p("a wild paragraph has appeared") }
  let(:localisations) { LOCALISATIONS }

  context 'localising when no text is supplied' do
    let(:expected_legend) { I18n.translate("helpers.fieldset.person.#{attribute}") }
    subject { builder.send(*args) { arbitrary_html_content } }

    specify 'should set the legend from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('fieldset') do
          with_tag('legend', with: { class: 'govuk-fieldset__legend' }) do
            with_tag('h1', text: expected_legend, with: { class: 'govuk-fieldset__heading' })
          end
        end
      end
    end
  end

  context 'allowing localised text to be overridden' do
    let(:expected_legend) { "It is quite a straightforward question!" }
    subject { builder.send(*args.push(legend: { text: expected_legend })) { arbitrary_html_content } }

    specify 'should set the legend from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('fieldset') do
          with_tag('legend', with: { class: 'govuk-fieldset__legend' }) do
            with_tag('h1', text: expected_legend, with: { class: 'govuk-fieldset__heading' })
          end
        end
      end
    end
  end
end

shared_examples 'a field that allows the label to be localised via a proc' do
  let(:locale) { :de }
  let(:localisations) do
    YAML.load_file('spec/support/locales/colours.de.yaml')
  end

  context 'localising collection items using procs' do
    subject { builder.send(*args) }

    specify 'labels should be present and correctly-localised' do
      with_localisations({ locale => localisations }, locale: locale) do
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

shared_examples 'a field that allows the hint to be localised via a proc' do
  let(:locale) { :de }
  let(:localisations) do
    YAML.load_file('spec/support/locales/colours.de.yaml')
  end

  context 'localising collection items using procs' do
    subject { builder.send(*args) }

    specify 'hints should be present and correctly-localised' do
      with_localisations({ locale => localisations }, locale: locale) do
        colours.each do |c|
          expect(subject).to have_tag(
            'span',
            text: localisations.dig("colours", c.name.downcase),
            with: { class: 'govuk-hint' }
          )
        end
      end
    end
  end
end
