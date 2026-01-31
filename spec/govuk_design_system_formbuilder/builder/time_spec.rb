describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_time_field' do
    let(:method) { :govuk_time_field }
    let(:attribute) { :born_at }

    let(:fieldset_heading) { 'Time of birth' }
    let(:legend_text) { 'When were you born?' }
    let(:hint_text) { 'It says it on your birth certificate' }

    let(:hour_multiparam_attribute) { '4i' }
    let(:minute_multiparam_attribute) { '5i' }
    let(:second_multiparam_attribute) { '6i' }
    let(:multiparam_attributes) { [hour_multiparam_attribute, minute_multiparam_attribute, second_multiparam_attribute] }

    let(:hour_identifier) { "person_born_at_#{hour_multiparam_attribute}" }
    let(:minute_identifier) { "person_born_at_#{minute_multiparam_attribute}" }
    let(:second_identifier) { "person_born_at_#{second_multiparam_attribute}" }

    let(:args) { [method, attribute] }
    subject { builder.send(*args) }

    let(:field_type) { 'input' }
    let(:aria_described_by_target) { 'fieldset' }

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports hints'

    it_behaves_like 'a field that supports errors' do
      let(:object) { Person.new(born_at: Time.new(2000, 1, 1, 11)) }

      let(:error_message) { /Your time of birth must be after midday/ }
      let(:error_class) { 'govuk-input--error' }
      let(:error_identifier) { 'person-born-at-error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'fieldset' }

      # the block content should be before the hint and time inputs
      context 'ordering' do
        let(:hint_div_selector) { 'div.govuk-hint' }
        let(:block_paragraph_selector) { 'p.block-content' }
        let(:govuk_date_selector) { 'div.govuk-date-input' }

        let(:paragraph) { 'A descriptive paragraph all about times' }

        subject do
          builder.send(*args, legend: { text: legend_text }, hint: { text: hint_text }) do
            builder.tag.p(paragraph, class: 'block-content')
          end
        end

        specify 'the block content should be before the hint and the time inputs' do
          actual = parsed_subject.css([hint_div_selector, block_paragraph_selector, govuk_date_selector].join(",")).flat_map(&:classes)
          expected = %w(block-content govuk-hint govuk-date-input)

          expect(actual).to eql(expected)
        end
      end
    end

    it_behaves_like 'a field that supports setting the legend via localisation'
    it_behaves_like 'a field that supports setting the legend caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    describe 'localising the hour, minute and second labels' do
      let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }
      let(:expected_hour_label) { I18n.translate("helpers.label.person.#{attribute}.hour") }
      let(:expected_minute_label) { I18n.translate("helpers.label.person.#{attribute}.minute") }
      let(:expected_second_label) { I18n.translate("helpers.label.person.#{attribute}.second") }

      subject { builder.send(*args) }

      specify 'the hour, minute and second labels are localised' do
        with_localisations(localisations) do
          aggregate_failures do
            expect(subject).to have_tag('label', text: expected_hour_label, with: { class: 'govuk-label' })
            expect(subject).to have_tag('label', text: expected_minute_label, with: { class: 'govuk-label' })
            expect(subject).to have_tag('label', text: expected_second_label, with: { class: 'govuk-label' })
          end
        end
      end
    end

    it_behaves_like 'a field that supports custom branding'
    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that supports a fieldset with legend'
    it_behaves_like 'a field that supports captions on the legend'

    it_behaves_like 'a time field that accepts a plain ruby object' do
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

    context 'separate time part inputs' do
      specify 'inputs should have the correct labels' do
        expect(subject).to have_tag('div', with: { class: 'govuk-date-input' }) do
          %w(Hour Minute Second).each do |label_text|
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
        [hour_identifier, minute_identifier, second_identifier].each do |identifier|
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
          count: 3,
          with: { class: %w(govuk-input--width-2) }
        )
      end
    end

    context 'when segments are overridden' do
      subject { builder.send(*args, segments: { hour: "hour", minute: "minute", second: "second" }) }

      specify "sets the hour field correctly" do
        expect(subject).to have_tag('input', with: { id: "person_born_at_hour", name: "person[born_at(hour)]" })
      end

      specify "sets the minute field correctly" do
        expect(subject).to have_tag('input', with: { id: "person_born_at_minute", name: "person[born_at(minute)]" })
      end

      specify "sets the second field correctly" do
        expect(subject).to have_tag('input', with: { id: "person_born_at_second", name: "person[born_at(second)]" })
      end
    end

    context 'when segment names are overridden' do
      subject { builder.send(*args, segment_names: { hour: "Hora", minute: "Minuto", second: "Segunda" }) }

      specify "sets the hour label correctly" do
        expect(subject).to have_tag('label', text: "Hora", with: { for: hour_identifier })
      end

      specify "sets the minute label correctly" do
        expect(subject).to have_tag('label', text: "Minuto", with: { for: minute_identifier })
      end

      specify "sets the second label correctly" do
        expect(subject).to have_tag('label', text: "Segunda", with: { for: second_identifier })
      end
    end

    context 'showing only hour and minute inputs' do
      subject { builder.send(*args, omit_second: true) }

      specify 'there should only be minute and second text inputs' do
        expect(subject).to have_tag('input', count: 3)

        [hour_multiparam_attribute, minute_multiparam_attribute].each do |mpa|
          expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{mpa})]", type: 'text' })
        end

        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{second_multiparam_attribute})]", type: 'hidden' })
      end

      specify 'there be no second label' do
        expect(subject).not_to have_tag('label', text: 'Second')
      end

      specify 'there should only be hour and minute labels' do
        expect(subject).to have_tag('label', text: 'Hour')
        expect(subject).to have_tag('label', text: 'Minute')
      end
    end

    context 'not restricting chars with maxlength' do
      subject { builder.send(*args, maxlength_enabled: false) }

      specify 'there should be a hour maxlength attribute' do
        expect(subject).not_to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{hour_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a minute maxlength attribute' do
        expect(subject).not_to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{minute_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a second maxlength attribute' do
        expect(subject).not_to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{second_multiparam_attribute})]", maxlength: '2' })
      end
    end

    context 'restricting chars with maxlength' do
      subject { builder.send(*args, maxlength_enabled: true) }

      specify 'there should be a hour maxlength attribute' do
        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{hour_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a minute maxlength attribute' do
        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{minute_multiparam_attribute})]", maxlength: '2' })
      end

      specify 'there should be a second maxlength attribute' do
        expect(subject).to have_tag('input', with: { name: "#{object_name}[#{attribute}(#{second_multiparam_attribute})]", maxlength: '2' })
      end
    end

    context 'default values' do
      let(:birth_hour) { 12 }
      let(:birth_minute) { 30 }
      let(:birth_second) { 45 }

      context "when the attribute is a `Date` object" do
        let(:object) do
          Person.new(
            name: 'Joey',
            born_at: Time.new(2000, 1, 1, birth_hour, birth_minute, birth_second)
          )
        end

        specify 'should set the hour value correctly' do
          expect(subject).to have_tag('input', with: {
            id: hour_identifier,
            value: birth_hour
          })
        end

        specify 'should set the minute value correctly' do
          expect(subject).to have_tag('input', with: {
            id: minute_identifier,
            value: birth_minute
          })
        end

        specify 'should set the second value correctly' do
          expect(subject).to have_tag('input', with: {
            id: second_identifier,
            value: birth_second
          })
        end
      end

      context "when the attribute is a multiparameter hash object" do
        let(:object) do
          Person.new(
            name: 'Joey',
            born_at: { 4 => birth_hour, 5 => birth_minute, 6 => birth_second }
          )
        end

        specify 'should set the hour value correctly' do
          expect(subject).to have_tag('input', with: {
            id: hour_identifier,
            value: birth_hour
          })
        end

        specify 'should set the minute value correctly' do
          expect(subject).to have_tag('input', with: {
            id: minute_identifier,
            value: birth_minute
          })
        end

        specify 'should set the second value correctly' do
          expect(subject).to have_tag('input', with: {
            id: second_identifier,
            value: birth_second
          })
        end
      end
    end

    describe "additional attributes" do
      subject { builder.send(*args, data: { test: "abc" }) }

      specify "should have additional attributes" do
        expect(subject).to have_tag('div', with: { 'data-test': 'abc' })
      end
    end

    describe "invalid time-like objects" do
      let(:wrong_time) { WrongTime.new(nil, nil, nil) }
      before { object.born_at = wrong_time }

      specify "fails with an appropriate error message" do
        expect { subject }.to raise_error(ArgumentError, /invalid Date-like object/)
      end
    end

    describe "hashes without the right keys" do
      let(:wrong_hash) { { h: 12, m: 30, s: 45 } }
      before { object.born_at = wrong_hash }
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
