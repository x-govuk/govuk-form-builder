LOCALISATIONS = {
  en: YAML.load_file('spec/support/locales/sample.en.yaml')
}.freeze

shared_examples 'a field that supports setting the label via localisation' do
  let(:localisations) { LOCALISATIONS }

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
end

shared_examples 'a field that supports setting the label caption via localisation' do
  let(:localisations) { LOCALISATIONS }

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
        expect(subject).to have_tag('span', text: expected_caption)
      end
    end
  end
end

shared_examples 'a field that supports setting the legend caption via localisation' do
  let(:localisations) { LOCALISATIONS }

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
        expect(subject).to have_tag('span', text: expected_caption)
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
      builder.send(*args, hint: { text: expected_hint }) { arbitrary_html_content }
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
    let(:expected_legend) { I18n.translate("helpers.legend.person.#{attribute}") }
    subject { builder.send(*args) { arbitrary_html_content } }

    specify 'should set the legend from the locales' do
      with_localisations(localisations) do
        expect(subject).to have_tag('fieldset') do
          with_tag('legend', with: { class: 'govuk-fieldset__legend' }) do
            with_tag('h1', text: Regexp.new(expected_legend), with: { class: 'govuk-fieldset__heading' })
          end
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
          with_tag('legend', with: { class: 'govuk-fieldset__legend' }) do
            with_tag('h1', text: Regexp.new(expected_legend), with: { class: 'govuk-fieldset__heading' })
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

shared_examples 'a field that supports localised collection labels' do
  let(:localisations) { LOCALISATIONS }
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

shared_examples 'a field that supports localised collection hints' do
  let(:localisations) { LOCALISATIONS }
  let(:attribute) { :department }
  subject { builder.send(*args) }

  specify 'the hints should be set by localisation' do
    with_localisations(localisations) do
      departments.each do |department|
        expected_hint = I18n.translate(department.code, scope: 'helpers.hint.person.department_options', default: nil)

        if expected_hint.present?
          expect(subject).to have_tag('span', with: { class: %w(govuk-hint).append(hint_class) }, text: expected_hint)
        end
      end

      # testing that the correct hint (sales) is missing is a bit 'involved',
      # so now we've ensured that the ones we expect to be there are present
      # let's make sure they're the only ones that are by counting them
      departments_with_localised_hints = departments.count do |department|
        I18n.translate(department.code, scope: 'helpers.hint.person.department_options', default: nil)
      end

      expect(subject).to have_tag('span', with: { class: %w(govuk-hint).append(hint_class) }, count: departments_with_localised_hints)
    end
  end
end
