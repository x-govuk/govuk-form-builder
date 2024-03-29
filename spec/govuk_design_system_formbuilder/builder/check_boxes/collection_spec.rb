describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe '#govuk_collection_check_boxes' do
    let(:attribute) { :projects }
    let(:method) { :govuk_collection_check_boxes }
    let(:field_type) { 'input' }
    let(:aria_described_by_target) { 'fieldset' }

    let(:args) { [method, attribute, projects, :id, :name] }
    subject { builder.send(*args) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        with_tag('fieldset', with: { class: 'govuk-fieldset' })
      end
    end

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports a fieldset with legend' do
      let(:legend_text) { 'Which projects is this person assigned to?' }
    end

    it_behaves_like 'a field that supports a fieldset with legend' do
      let(:legend_text) { 'Which projects is this person assigned to?' }
    end

    it_behaves_like 'a field that supports hints' do
      let(:hint_text) { 'The most agile project in the world!' }
    end

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Select at least one project/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-projects-error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'fieldset' }
    end

    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports custom classes' do
      let(:element) { 'div' }
      let(:default_classes) { %w(govuk-checkboxes) }
    end

    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that supports setting the legend via localisation'
    it_behaves_like 'a field that supports setting the legend caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { ['input', { with: { type: 'checkbox' }, count: projects.size }] }
    end

    describe 'check boxes' do
      specify 'output should contain the correct number of check boxes' do
        expect(subject).to have_tag('div', with: { 'data-module' => 'govuk-checkboxes' }) do
          with_tag('input', count: projects.size, with: { type: 'checkbox' })
          with_tag('label', count: projects.size)
        end
      end

      specify 'a hidden field is present by default' do
        expect(subject).to have_tag('input', with: { type: 'hidden', name: "#{object_name}[#{attribute}][]" })
      end

      context 'check box size' do
        context 'when small is specified in the options' do
          subject { builder.send(*args, small: true) }

          specify "should have the additional class 'govuk-checkboxes--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-checkboxes govuk-checkboxes--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject { builder.send(*args) }

          specify "should not have the additional class 'govuk-checkboxes--small'" do
            expect(parsed_subject.at_css('.govuk-checkboxes')['class']).to eql('govuk-checkboxes')
          end
        end
      end

      context 'check box labels' do
        specify 'labels should contain the correct content' do
          projects.map(&:name).each do |label_text|
            expect(subject).to have_tag('label', text: label_text, with: { class: %w(govuk-label govuk-checkboxes__label) })
          end
        end

        specify 'labels should be correctly associated with inputs' do
          parsed_subject.css('.govuk-checkboxes__item').each do |item|
            input_id = item.at_css('input').attribute('id').value
            label_target = item.at_css('label').attribute('for').value

            expect(input_id).to eql(label_target)
          end
        end

        specify 'labels should have the correct classes' do
          expect(subject).to have_tag('label', with: { class: 'govuk-label' }, count: projects.size)
        end
      end

      context 'check box hints' do
        context 'when a hint method is provided' do
          subject { builder.send(*args.push(:description)) }

          specify 'hints should contain the correct content' do
            projects.map(&:description).compact.each do |hint_text|
              expect(subject).to have_tag('div', text: hint_text, with: { class: %w(govuk-hint govuk-checkboxes__hint) })
            end
          end

          specify 'hints should be correctly associated with inputs' do
            parsed_subject.css('.govuk-checkboxes__item').each do |item|
              next unless (described_by = item.at_css('input').attribute('aria-describedby'))

              input_described_by = described_by.value
              hint_id = item.at_css('.govuk-hint').attribute('id').value

              expect(hint_id).to eql(input_described_by)
            end
          end

          specify 'only items with descriptions should have hints' do
            expect(subject).to have_tag('div', with: { class: 'govuk-hint' }, count: projects_with_descriptions.size)
          end

          specify 'hints should have the correct classes' do
            expect(subject).to have_tag('div', with: { class: %w(govuk-hint govuk-checkboxes__hint) })
          end
        end

        context 'when no hint method is provided' do
          specify 'the hint tag should never be present' do
            expect(subject).not_to have_tag('div', with: { class: 'govuk-hint' })
          end
        end
      end

      it_behaves_like 'a field that allows the hint to be localised via a proc' do
        let(:attribute) { :favourite_colour }
        let(:i18n_proc) { ->(item) { I18n.t("colours.#{item.name.downcase}") } }
        let(:args) { [method, attribute, colours, :id, :name].push(i18n_proc) }
      end

      it_behaves_like 'a field that supports localised collection hints' do
        let(:hint_class) { 'govuk-checkboxes__hint' }
        let(:args) { [method, :department, departments, :code, :name] }
      end

      it_behaves_like 'a collection field that supports setting the value via a proc' do
        let(:attribute) { :favourite_colour }
      end

      context 'suppressing the hidden field' do
        subject { builder.send(*args, include_hidden: false) }

        specify "the hidden field should be present within the fieldset" do
          expect(subject).not_to have_tag('input', with: { type: 'hidden' })
        end
      end
    end
  end
end
