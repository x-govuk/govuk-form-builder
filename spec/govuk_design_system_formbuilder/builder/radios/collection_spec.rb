describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'
  include_context 'setup radios'

  describe '#govuk_collection_radio_buttons' do
    let(:method) { :govuk_collection_radio_buttons }
    let(:colours) do
      [
        OpenStruct.new(id: 'red', name: 'Red', description: red_hint),
        OpenStruct.new(id: 'blue', name: 'Blue', description: blue_hint),
        OpenStruct.new(id: 'green', name: 'Green'),
        OpenStruct.new(id: 'yellow', name: 'Yellow')
      ]
    end

    let(:args) { [method, attribute, colours, :id, :name] }
    subject { builder.send(*args) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' })
      end
    end

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports custom classes' do
      let(:element) { 'div' }
      let(:default_classes) { %w(govuk-radios) }
    end

    it_behaves_like 'a field that supports a fieldset with legend' do
      let(:legend_text) { 'Pick your favourite colour' }
    end

    it_behaves_like 'a field that supports captions on the legend' do
      let(:legend_text) { 'Pick your favourite colour' }
    end

    it_behaves_like 'a field that supports hints' do
      let(:hint_text) { 'The colour of your favourite handkerchief' }
    end

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-favourite-colour-error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'fieldset' }
    end

    it_behaves_like 'a field that supports setting the hint via localisation'
    it_behaves_like 'a field that supports setting the legend caption via localisation'

    it_behaves_like 'a field that supports localised collection labels' do
      let(:args) { [method, :department, departments, :code] }
    end

    it_behaves_like 'a field that supports localised collection hints' do
      let(:hint_class) { 'govuk-radios__hint' }
      let(:args) { [method, :department, departments, :code] }
    end

    it_behaves_like 'a field that supports setting the legend via localisation'
    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { ['input', { with: { type: 'radio' }, count: colours.size }] }
    end

    describe 'radio buttons' do
      specify 'each radio button should have the correct classes' do
        expect(subject).to have_tag('input', with: { class: %w(govuk-radios__input) }, count: colours.size)
      end

      specify %(shouldn't have a hidden field by default) do
        expect(subject).to have_tag('fieldset') do
          with_tag('input', with: { type: 'hidden', name: "#{object_name}[#{attribute}]" })
        end
      end

      specify 'each label should have the correct classes' do
        expect(subject).to have_tag('label', count: colours.size, with: { class: %w(govuk-label govuk-radios__label) })
      end

      specify 'there should be the correct number' do
        expect(subject).to have_tag('input', count: colours.size, with: { type: 'radio' })
        expect(subject).to have_tag('label', count: colours.size)
      end

      specify 'radio buttons should be surrounded by a radios module' do
        expect(subject).to have_tag('div', with: { 'data-module' => 'govuk-radios' }) do |dm|
          expect(dm).to have_tag('input', count: colours.size, with: { type: 'radio' })
        end
      end

      specify 'each radio button should have the correct id' do
        colours.each do |colour|
          "person-favourite-colour-#{colour.id}-field".tap do |association|
            expect(subject).to have_tag('input', with: { id: association })
          end
        end
      end

      specify 'radio buttons should have the correct name' do
        names = parsed_subject.css('input').map { |e| e['name'] }

        expect(names).to all(eql('person[favourite_colour]'))
      end

      specify 'radio buttons should be associated with corresponding labels' do
        colours.each do |colour|
          "person-favourite-colour-#{colour.id}-field".tap do |association|
            expect(subject).to have_tag('input', with: { id: association })
            expect(subject).to have_tag('label', with: { for: association })
          end
        end
      end

      it_behaves_like 'a field that allows the label to be localised via a proc' do
        let(:i18n_proc) { ->(item) { I18n.t("colours.#{item.name.downcase}") } }
        let(:args) { [method, attribute, colours, :id, i18n_proc] }
      end

      it_behaves_like 'a collection field that supports setting the value via a proc'

      context 'radio button hints' do
        let(:colours_with_descriptions) { colours.select { |c| c.description.present? } }
        let(:colours_without_descriptions) { colours.reject { |c| c.description.present? } }

        subject { builder.send(*args.push(:description)) }

        specify 'the radio buttons with hints should contain hint text' do
          expect(subject).to have_tag('span', count: colours_with_descriptions.size, with: { class: 'govuk-hint govuk-radios__hint' })
        end

        specify 'the hint should be associated with the correct radio button' do
          colours_with_descriptions.each do |cwd|
            "person-favourite-colour-#{cwd.id}-hint".tap do |association|
              expect(subject).to have_tag('input', with: { "aria-describedby" => association })
              expect(subject).to have_tag('span', with: { class: 'govuk-hint', id: association })
            end
          end
        end

        specify 'radio buttons without hints should not have aria-describedby attributes' do
          colours_without_descriptions.each do |cwd|
            "person-favourite_colour-#{cwd.id}-hint".tap do |association|
              expect(subject).not_to have_tag('input', with: { "aria-describedby" => association })
            end
          end
        end

        specify 'all labels should be bold when hints are enabled' do
          expect(subject).to have_tag('label', with: { class: 'govuk-label--s' }, count: colours.size)
        end

        it_behaves_like 'a field that allows the hint to be localised via a proc' do
          let(:i18n_proc) { ->(item) { I18n.t("colours.#{item.name.downcase}") } }
          let(:args) { [method, attribute, colours, :id, :name, i18n_proc] }
        end
      end

      context 'layout direction' do
        context 'when inline is specified in the options' do
          subject do
            builder.send(*args.push(:description), inline: true)
          end

          specify "should have the additional class 'govuk-radios--inline'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--inline) })
          end
        end

        context 'when inline is not specified in the options' do
          subject do
            builder.send(*args.push(:description), inline: false)
          end

          specify "should not have the additional class 'govuk-radios--inline'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'radio button size' do
        context 'when small is specified in the options' do
          subject do
            builder.send(*args.push(:description), small: true)
          end

          specify "should have the additional class 'govuk-radios--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-radios govuk-radios--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject do
            builder.send(*args.push(:description), small: false)
          end

          specify "should not have the additional class 'govuk-radios--small'" do
            expect(parsed_subject.at_css('.govuk-radios')['class']).to eql('govuk-radios')
          end
        end
      end

      context 'bold labels' do
        let(:bold_label_class) { 'govuk-label--s' }

        context 'when bold labels are specified in the options' do
          subject do
            builder.send(*args.push(:description), bold_labels: true)
          end

          specify 'all labels should be bold when hints are enabled' do
            expect(subject).to have_tag('label', with: { class: bold_label_class }, count: colours.size)
          end
        end

        context 'when bold labels are not specified in the options' do
          specify 'no labels should be bold when hints are enabled' do
            expect(subject).not_to have_tag('label', with: { class: bold_label_class })
          end
        end
      end

      context 'generating a hidden field' do
        subject { builder.send(*args, include_hidden: false) }

        specify "the hidden field should be present within the fieldset" do
          expect(subject).not_to have_tag('input', with: { type: 'hidden' })
        end
      end
    end
  end
end
