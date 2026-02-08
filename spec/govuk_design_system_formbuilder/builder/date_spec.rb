describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_date_field' do
    let(:method) { :govuk_date_field }
    let(:attribute) { :born_on }

    let(:fieldset_heading) { 'Date of birth' }
    let(:legend_text) { 'When were you born?' }
    let(:hint_text) { 'It says it on your birth certificate' }

    let(:day_multiparam_attribute) { '3i' }
    let(:month_multiparam_attribute) { '2i' }
    let(:year_multiparam_attribute) { '1i' }
    let(:multiparam_attributes) { [day_multiparam_attribute, month_multiparam_attribute, year_multiparam_attribute] }

    let(:day_identifier) { "person_born_on_#{day_multiparam_attribute}" }
    let(:month_identifier) { "person_born_on_#{month_multiparam_attribute}" }
    let(:year_identifier) { "person_born_on_#{year_multiparam_attribute}" }

    let(:args) { [method, attribute] }
    subject { builder.send(*args) }

    let(:field_type) { 'input' }
    let(:aria_described_by_target) { 'fieldset' }

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports hints'

    it_behaves_like 'a field that supports errors' do
      let(:object) { Person.new(born_on: Date.today.next_year(5)) }

      let(:error_message) { /Your date of birth must be in the past/ }
      let(:error_class) { 'govuk-input--error' }
      let(:error_identifier) { 'person-born-on-error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'fieldset' }

      # the block content should be before the hint and date inputs
      context 'ordering' do
        let(:hint_div_selector) { 'div.govuk-hint' }
        let(:block_paragraph_selector) { 'p.block-content' }
        let(:govuk_date_selector) { 'div.govuk-date-input' }

        let(:paragraph) { 'A descriptive paragraph all about dates' }

        subject do
          builder.send(*args, legend: { text: legend_text }, hint: { text: hint_text }) do
            builder.tag.p(paragraph, class: 'block-content')
          end
        end

        specify 'the block content should be before the hint and the date inputs' do
          actual = parsed_subject.css([hint_div_selector, block_paragraph_selector, govuk_date_selector].join(",")).flat_map(&:classes)
          expected = %w(block-content govuk-hint govuk-date-input)

          expect(actual).to eql(expected)
        end
      end
    end

    it_behaves_like 'a field that supports setting the legend via localisation'
    it_behaves_like 'a field that supports setting the legend caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'
    it_behaves_like 'a field that supports adding content before and after inputs' do
      let(:multiple_inputs) { true }
    end

    describe 'localising the day, month and year labels' do
      let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }
      let(:expected_day_label) { I18n.translate("helpers.label.person.#{attribute}.day") }
      let(:expected_month_label) { I18n.translate("helpers.label.person.#{attribute}.month") }
      let(:expected_year_label) { I18n.translate("helpers.label.person.#{attribute}.year") }

      subject { builder.send(*args) }

      specify 'the day, month and year labels are localised' do
        with_localisations(localisations) do
          aggregate_failures do
            expect(subject).to have_tag('label', text: expected_day_label, with: { class: 'govuk-label' })
            expect(subject).to have_tag('label', text: expected_month_label, with: { class: 'govuk-label' })
            expect(subject).to have_tag('label', text: expected_year_label, with: { class: 'govuk-label' })
          end
        end
      end
    end

    it_behaves_like 'a field that supports custom branding'
    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that supports a fieldset with legend'
    it_behaves_like 'a field that supports captions on the legend'

    it_behaves_like 'a date field that accepts a plain ruby object' do
      let(:described_element) { ['input', { count: 3 }] }
    end

    specify 'should output a form group with fieldset, date group and 3 inputs and labels' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        with_tag('fieldset', with: { class: 'govuk-fieldset' }) do
          with_tag('div', with: { class: 'govuk-date-input' }) do
            with_tag('input', with: { type: 'text' }, count: 3)
            with_tag('label', count: 3)
          end
        end
      end
    end

    context 'separate date part inputs' do
      specify 'inputs should have the correct labels' do
        expect(subject).to have_tag('div', with: { class: 'govuk-date-input' }) do
          %w(Day Month Year).each do |label_text|
            with_tag('label', text: label_text)
          end
        end
      end

      specify 'inputs should have the correct name' do
        multiparam_attributes.each do |mpa|
          expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{mpa})]" })
        end
      end

      specify 'inputs should have an inputmode of numeric' do
        expect(subject).to have_tag('input', with: { inputmode: 'numeric' })
      end

      specify 'labels should be associated with inputs' do
        [day_identifier, month_identifier, year_identifier].each do |identifier|
          expect(subject).to have_tag('label', with: { for: identifier }, count: 1)
          expect(subject).to have_tag('input', with: { id: identifier }, count: 1)
        end
      end

      specify 'inputs should have the correct classes' do
        expect(subject).to have_tag(
          'input',
          count: 3,
          with: { class: %w(govuk-input govuk-date-input__input) }
        )
      end

      specify 'inputs should have the width class' do
        expect(subject).to have_tag(
          'input',
          count: 2,
          with: { class: %w(govuk-input--width-2) }
        )

        expect(subject).to have_tag(
          'input',
          count: 1,
          with: { class: %w(govuk-input--width-4) }
        )
      end
    end

    context 'when segments are overridden' do
      subject { builder.send(*args, segments: { day: "day", month: "month", year: "year" }) }

      specify "sets the day field correctly" do
        expect(subject).to have_tag('input', with: { id: "person_born_on_day", name: "person[born_on(day)]" })
      end

      specify "sets the month field correctly" do
        expect(subject).to have_tag('input', with: { id: "person_born_on_month", name: "person[born_on(month)]" })
      end

      specify "sets the year field correctly" do
        expect(subject).to have_tag('input', with: { id: "person_born_on_year", name: "person[born_on(year)]" })
      end
    end

    context 'when segment names are overridden' do
      subject { builder.send(*args, segment_names: { day: "Tag", month: "Monat", year: "Jahr" }) }

      specify "sets the day label correctly" do
        expect(subject).to have_tag('label', text: "Tag", with: { for: day_identifier })
      end

      specify "sets the month label correctly" do
        expect(subject).to have_tag('label', text: "Monat", with: { for: month_identifier })
      end

      specify "sets the year label correctly" do
        expect(subject).to have_tag('label', text: "Jahr", with: { for: year_identifier })
      end
    end

    context 'showing only month and year inputs' do
      subject { builder.send(*args, omit_day: true) }

      specify 'there should only be month and year text inputs' do
        expect(subject).to have_tag('input', count: 3)

        [month_multiparam_attribute, year_multiparam_attribute].each do |mpa|
          expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{mpa})]", type: 'text' })
        end

        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{day_multiparam_attribute})]", type: 'hidden' })
      end

      specify 'there be no day label' do
        expect(subject).not_to have_tag('label', text: 'Day')
      end

      specify 'there should only be month and year labels' do
        expect(subject).to have_tag('label', text: 'Month')
        expect(subject).to have_tag('label', text: 'Year')
      end
    end

    context 'not restricting chars with maxlength' do
      subject { builder.send(*args, maxlength_enabled: false) }

      specify 'there should be a day maxlength attribute' do
        expect(subject).not_to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{day_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a month maxlength attribute' do
        expect(subject).not_to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{month_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a year maxlength attribute' do
        expect(subject).not_to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{year_multiparam_attribute})]", maxlength: '4' })
      end
    end

    context 'restricting chars with maxlength' do
      subject { builder.send(*args, maxlength_enabled: true) }

      specify 'there should be a day maxlength attribute' do
        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{day_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a month maxlength attribute' do
        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{month_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a year maxlength attribute' do
        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{year_multiparam_attribute})]", maxlength: '4' })
      end
    end

    context 'default values' do
      let(:birth_day) { 3 }
      let(:birth_month) { 2 }
      let(:birth_year) { 1970 }

      context "when the attribute is a `Date` object" do
        let(:object) do
          Person.new(
            name: 'Joey',
            born_on: Date.new(birth_year, birth_month, birth_day)
          )
        end

        specify 'should set the day value correctly' do
          expect(subject).to have_tag('input', with: {
            id: day_identifier,
            value: birth_day
          })
        end

        specify 'should set the month value correctly' do
          expect(subject).to have_tag('input', with: {
            id: month_identifier,
            value: birth_month
          })
        end

        specify 'should set the year value correctly' do
          expect(subject).to have_tag('input', with: {
            id: year_identifier,
            value: birth_year
          })
        end
      end

      context "when the attribute is a multiparameter hash object" do
        let(:object) do
          Person.new(
            name: 'Joey',
            born_on: { 3 => birth_day, 2 => birth_month, 1 => birth_year }
          )
        end

        specify 'should set the day value correctly' do
          expect(subject).to have_tag('input', with: {
            id: day_identifier,
            value: birth_day
          })
        end

        specify 'should set the month value correctly' do
          expect(subject).to have_tag('input', with: {
            id: month_identifier,
            value: birth_month
          })
        end

        specify 'should set the year value correctly' do
          expect(subject).to have_tag('input', with: {
            id: year_identifier,
            value: birth_year
          })
        end
      end
    end

    context 'auto-completion' do
      context 'date of birth' do
        subject { builder.send(*args, date_of_birth: true) }
        specify "day field should have autocomplete attribute with value 'bday-day'" do
          expect(subject).to have_tag('input', with: { autocomplete: 'bday-day' })
        end

        specify "month field should have autocomplete attribute with value 'bday-month'" do
          expect(subject).to have_tag('input', with: { autocomplete: 'bday-month' })
        end

        specify "year field should have autocomplete attribute with value 'bday-year'" do
          expect(subject).to have_tag('input', with: { autocomplete: 'bday-year' })
        end
      end
    end

    describe "additional attributes" do
      subject { builder.send(*args, data: { test: "abc" }) }

      specify "should have additional attributes" do
        expect(subject).to have_tag('div', with: { 'data-test': 'abc' })
      end
    end

    describe "invalid date-like objects" do
      let(:wrong_date) { WrongDate.new(nil, nil, nil) }
      before { object.born_on = wrong_date }

      specify "fails with an appropriate error message" do
        expect { subject }.to raise_error(ArgumentError, /invalid Date-like object/)
      end
    end

    describe "hashes without the right keys" do
      let(:wrong_hash) { { d: 20, m: 3, y: 2009 } }
      before { object.born_on = wrong_hash }
      before { allow(Rails).to receive_message_chain(:logger, :warn) }
      before { subject }

      specify "logs an appropriate warning" do
        expect(Rails.logger).to have_received(:warn).with(/No key '.*' found in MULTIPARAMETER_KEY hash/).exactly(wrong_hash.length).times
      end

      specify "doesn't generate inputs with values" do
        parsed_subject.css('input').each do |element|
          expect(element.attributes.keys).not_to include('value')
        end
      end
    end
  end
end
