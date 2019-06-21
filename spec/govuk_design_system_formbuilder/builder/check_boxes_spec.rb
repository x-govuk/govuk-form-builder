describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  let(:project_x) { Project.new(id: 1, name: 'Project X', description: 'Xanthous, xylophone, xenon') }
  let(:project_y) { Project.new(id: 2, name: 'Project Y', description: 'Yellow, yoga, yacht') }
  let(:project_z) { Project.new(id: 3, name: 'Project Z', description: nil) }

  let(:projects) { [project_x, project_y, project_z] }

  describe '#govuk_collection_check_boxes' do
    let(:attribute) { :projects }
    let(:method) { :govuk_collection_check_boxes }

    subject { builder.send(method, attribute, projects, :id, :name) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' })
      end
    end

    context 'fieldset options' do
      context 'legend' do
        let(:text) { 'Which projects is this person assigned to?' }

        context 'when supplied with custom text' do
          subject { builder.send(method, attribute, projects, :id, :name, legend: { text: text }) }

          specify 'should contain a fieldset header containing the supplied text' do
            expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
              expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                expect(fs).to have_tag('h1', text: text, with: { class: 'govuk-fieldset__heading' })
              end
            end
          end
        end

        context 'when no text is supplied' do
          subject { builder.send(method, attribute, projects, :id, :name, legend: { text: nil }) }

          specify 'output should not contain a header' do
            expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
              expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                expect(fs).not_to have_tag('h1')
              end
            end
          end
        end

        context 'when supplied with a custom tag' do
          let(:tag) { 'h4' }
          subject { builder.send(method, attribute, projects, :id, :name, legend: { text: text, tag: tag }) }

          specify 'output fieldset should contain the specified tag' do
            expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
              expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                expect(fs).to have_tag(tag, text: text)
              end
            end
          end
        end

        context 'when supplied with a custom size' do
          context 'with a valid size' do
            let(:size) { 'm' }
            subject { builder.send(method, attribute, projects, :id, :name, legend: { text: text, size: size }) }

            specify 'output fieldset should contain the specified tag' do
              expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
                expect(fg).to have_tag('div', with: { class: 'govuk-fieldset' }) do |fs|
                  expect(fs).to have_tag('h1', text: text, class: "govuk-fieldset__legend--#{size}")
                end
              end
            end
          end

          context 'with an invalid size' do
            let(:size) { 'miniscule' }
            subject { builder.send(method, attribute, projects, :id, :name, legend: { text: text, size: size }) }

            specify 'should raise an appropriate error' do
              expect { subject }.to raise_error(/invalid size #{size}/)
            end
          end
        end
      end
    end

    context 'when a hint is provided' do
      let(:hint) { 'The colour of your favourite handkerchief' }
      subject { builder.send(method, attribute, projects, :id, :name, hint: { text: hint }) }

      specify 'output should contain a hint' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('span', text: hint, with: { class: 'govuk-hint' })
        end
      end

      specify 'output should also contain the fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-fieldset' })
      end

      specify 'the hint should be associated with the fieldset' do
        expect(parsed_subject.at_css('.govuk-fieldset')['aria-describedby'].split).to include(
          parsed_subject.at_css('.govuk-form-group > .govuk-hint')['id']
        )
      end
    end

    context 'when passed a block' do
      let(:block_h1) { 'The quick brown fox' }
      let(:block_h2) { 'Jumped over the' }
      let(:block_p) { 'Lazy dog.' }
      subject do
        builder.send(method, attribute, projects, :id, :name) do
          builder.safe_join([
            builder.tag.h1(block_h1),
            builder.tag.h2(block_h2),
            builder.tag.p(block_p)
          ])
        end
      end

      specify 'should include block content' do
        expect(subject).to have_tag('h1', text: block_h1)
        expect(subject).to have_tag('h2', text: block_h2)
        expect(subject).to have_tag('p', text: block_p)
      end
    end

    describe 'check boxes' do
      subject { builder.send(method, attribute, projects, :id, :name) }

      specify 'output should contain the correct number of check boxes' do
        expect(subject).to have_tag('input', count: projects.size, with: { type: 'checkbox' })
        expect(subject).to have_tag('label', count: projects.size)
      end

      context 'labels' do
        specify 'labels should contain the correct content' do
          projects.map(&:name).each do |label_text|
            expect(subject).to have_tag('label', text: label_text, with: { class: 'govuk-label govuk-checkboxes__label' })
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

      context 'hints' do
        let(:projects_with_descriptions) { projects.select { |p| p.description.present? } }
        context 'when a hint method is provided' do
          subject { builder.send(method, attribute, projects, :id, :name, :description) }

          specify 'hints should contain the correct content' do
            projects.map(&:description).compact.each do |hint_text|
              expect(subject).to have_tag('span', text: hint_text, with: { class: %w(govuk-hint govuk-checkboxes__hint) })
            end
          end

          specify 'hints should be correctly associated with inputs' do
            parsed_subject.css('.govuk-checkboxes__item').each do |item|
              next unless described_by = item.at_css('input').attribute('aria-describedby')

              input_described_by = described_by.value
              hint_id = item.at_css('.govuk-hint').attribute('id').value

              expect(hint_id).to eql(input_described_by)
            end
          end

          specify 'only items with descriptions should have hints' do
            expect(subject).to have_tag('span', with: { class: 'govuk-hint' }, count: projects_with_descriptions.size)
          end

          specify 'hints should have the correct classes' do
            expect(subject).to have_tag('span', with: { class: %w(govuk-hint govuk-checkboxes__hint) })
          end
        end

        context 'when no hint method is provided' do
          specify 'the hint tag should never be present' do
            expect(subject).not_to have_tag('span', with: { class: 'govuk-hint' })
          end
        end
      end
    end
  end
end
