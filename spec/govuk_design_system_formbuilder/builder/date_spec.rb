describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#date_input_group' do
    let(:method) { :govuk_date_field }
    let(:attribute) { :born_on }

    let(:fieldset_heading) { 'Date of birth' }
    let(:legend_text) { 'When were you born?' }
    let(:hint_text) { 'It says it on your birth certificate' }

    let(:day_identifier) { 'person_born_on_3i' }
    let(:month_identifier) { 'person_born_on_2i' }
    let(:year_identifier) { 'person_born_on_1i' }


    subject { builder.send(method, attribute) }

    specify 'should output a form group with fieldset, date group and 3 inputs and labels' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('div', with: { class: 'govuk-fieldset'}) do |fs|
          expect(fs).to have_tag('div', with: { class: 'govuk-date-input' }) do |di|
            expect(di).to have_tag('input', with: { type: 'number' }, count: 3)
            expect(di).to have_tag('label', count: 3)
          end
        end
      end
    end

    context 'separate date part inputs' do
      specify 'inputs should have the correct labels' do
        expect(subject).to have_tag('div', with: { class: 'govuk-date-input' }) do |di|
          %w(Day Month Year).each do |label_text|
            expect(di).to have_tag('label', text: label_text)
          end
        end
      end

      context 'min and max' do
        specify 'day should allow values of 1-31' do
          expect(subject).to have_tag('input', with: { id: day_identifier, min: 1, max: 31 })
        end

        specify 'month should allow values of 1-12' do
          expect(subject).to have_tag('input', with: { id: month_identifier, min: 1, max: 12 })
        end

        specify 'year should allow values of 1900-2100' do
          expect(subject).to have_tag('input', with: { id: year_identifier, min: 1900, max: 2100 })
        end
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

    specify 'labels should be associated with inputs' do
      [day_identifier, month_identifier, year_identifier].each do |identifier|
        expect(subject).to have_tag('label', with: { for: identifier }, count: 1)
        expect(subject).to have_tag('input', with: { id: identifier }, count: 1)
      end
    end

    context 'legend' do
      context 'when a legend is supplied' do
        subject { builder.send(method, attribute, legend: { text: legend_text }) }
        specify 'legend tag should be present and have the correct contents' do
          expect(subject).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
            expect(fs).to have_tag('legend', with: { class: 'govuk-fieldset__legend' }) do |legend|
              expect(legend).to have_tag('h1', text: legend_text, with: { class: 'govuk-fieldset__heading' })
            end
          end
        end
      end

      context 'when no legend is supplied' do
        specify 'legend tag should not be present' do
          expect(subject).not_to have_tag('legend')
        end
      end
    end

    context 'hint' do
      context 'when a hint is supplied' do
        subject { builder.send(method, attribute, hint: { text: hint_text }) }
        specify 'hint should be present' do
          expect(subject).to have_tag('span', text: hint_text, with: { class: %w(govuk-hint) })
        end
      end

      context 'when no hint is supplied' do
        specify 'hint should not be present' do
          expect(subject).not_to have_tag('span', with: { class: %w(govuk-hint) })
        end
      end
    end

    context 'default values' do
      let(:birth_day) { 3 }
      let(:birth_month) { 2 }
      let(:birth_year) { 1970 }
      let(:object) do
        Person.new(
          name: 'Joey',
          born_on: Date.new(birth_year, birth_month, birth_day)
        )
      end

      subject { builder.send(method, attribute) }

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

    context 'block' do
      let(:paragraph) { 'A descriptive paragraph all about dates' }
      subject do
        builder.send(method, attribute, legend: { text: legend_text }, hint: { text: hint_text }) do
          builder.tag.p(paragraph, class: 'block-content')
        end
      end

      specify 'should add the block content in addition to the other elements' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('input', count: 3)
          expect(fg).to have_tag('legend', text: legend_text)
          expect(fg).to have_tag('span', with: { class: 'govuk-hint' }, text: hint_text)

          expect(fg).to have_tag('p', paragraph)
        end
      end

      # the block content (p) shold be between the hint (span) and the input container (div)
      let(:hint_span_selector) { 'span.govuk-hint' }
      let(:block_paragraph_selector) { 'p.block-content' }
      let(:govuk_date_selector) { 'div.govuk-date-input' }

      specify 'the block content should be between the hint and the date inputs' do
        expect(
          parsed_subject.css([hint_span_selector, block_paragraph_selector, govuk_date_selector].join(',')).map(&:name)
        ).to eql(%w(span p div))
      end
    end

    context 'dates of birth' do
      context 'auto-completion attributes' do
        specify "day field should have autocomplete attribute with value 'bday-day'"
        specify "month field should have autocomplete attribute with value 'bday-month'"
        specify "year field should have autocomplete attribute with value 'bday-year'"
      end
    end
  end
end
