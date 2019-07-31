describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_collection_check_boxes' do
    let(:attribute) { :projects }
    let(:method) { :govuk_collection_check_boxes }
    let(:field_type) { 'input' }
    let(:aria_described_by_target) { 'fieldset' }

    let(:args) { [method, attribute, projects, :id, :name] }
    subject { builder.send(*args) }

    specify 'output should be a form group containing a form group and fieldset' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' })
      end
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

    context 'when passed a block' do
      let(:block_h1) { 'The quick brown fox' }
      let(:block_h2) { 'Jumped over the' }
      let(:block_p) { 'Lazy dog.' }
      subject do
        builder.send(*args) do
          builder.safe_join(
            [
              builder.tag.h1(block_h1),
              builder.tag.h2(block_h2),
              builder.tag.p(block_p)
            ]
          )
        end
      end

      specify 'should include block content' do
        expect(subject).to have_tag('h1', text: block_h1)
        expect(subject).to have_tag('h2', text: block_h2)
        expect(subject).to have_tag('p', text: block_p)
      end
    end

    describe 'check boxes' do
      specify 'output should contain the correct number of check boxes' do
        expect(subject).to have_tag('input', count: projects.size, with: { type: 'checkbox' })
        expect(subject).to have_tag('label', count: projects.size)
      end

      context 'check box size' do
        context 'when small is specified in the options' do
          subject { builder.send(*args.push(small: true)) }

          specify "should have the additional class 'govuk-checkboxes--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-checkboxes govuk-checkboxes--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject { builder.send(method, attribute, projects, :id, :name) }

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
              expect(subject).to have_tag('span', text: hint_text, with: { class: %w(govuk-hint govuk-checkboxes__hint) })
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

  describe '#govuk_check_boxes_fieldset' do
    let(:attribute) { :projects }
    let(:method) { :govuk_check_boxes_fieldset }
    let(:field_type) { 'input' }
    let(:aria_described_by_target) { 'fieldset' }
    let(:args) { [method, attribute] }

    subject do
      builder.send(*args) do
        builder.safe_join(
          projects.map do |p|
            builder.govuk_check_box(attribute, p.id)
          end
        )
      end
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Select at least one project/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-projects-error' }
    end

    context 'when no block is supplied' do
      subject { builder.send(*args) }
      specify { expect { subject }.to raise_error(NoMethodError, /undefined method.*call/) }
    end

    context 'when a block containing check boxes is supplied' do
      specify 'output should be a form group containing a form group and fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('fieldset', with: { class: 'govuk-fieldset' })
        end
      end

      specify 'output should contain check boxes' do
        expect(subject).to have_tag('div', with: { class: 'govuk-checkboxes', 'data-module' => 'checkboxes' }) do
          expect(subject).to have_tag('input', with: { type: 'checkbox' }, count: 3)
        end
      end

      context 'check box size' do
        context 'when small is specified in the options' do
          subject do
            builder.govuk_check_boxes_fieldset(:projects, small: true) do
              builder.safe_join(
                projects.map do |p|
                  builder.govuk_check_box(attribute, p.id)
                end
              )
            end
          end

          specify "should have the additional class 'govuk-checkboxes--small'" do
            expect(subject).to have_tag('div', with: { class: %w(govuk-checkboxes govuk-checkboxes--small) })
          end
        end

        context 'when small is not specified in the options' do
          subject do
            builder.govuk_check_boxes_fieldset(:projects) do
              builder.safe_join(
                projects.map do |p|
                  builder.govuk_check_box(attribute, p.id)
                end
              )
            end
          end

          specify "should not have the additional class 'govuk-checkboxes--small'" do
            expect(parsed_subject.at_css('.govuk-checkboxes')['class']).to eql('govuk-checkboxes')
          end
        end
      end
    end
  end

  describe '#govuk_check_box' do
    let(:method) { :govuk_check_box }
    let(:attribute) { :projects }
    let(:value) { project_x.id }
    let(:args) { [method, attribute, value] }

    subject { builder.send(*args) }

    specify 'output should contain a check box item group with a check box input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-checkboxes__item' }) do |ci|
        expect(ci).to have_tag('input', with: { type: 'checkbox', value: value })
      end
    end

    it_behaves_like 'a field that supports labels' do
      let(:label_text) { 'Project X' }
      # the reason we're specifying the type is that
      # Rails injects a hidden input in addition to the
      # checkbox
      let(:field_type) { "input[type='checkbox']" }

      specify 'the label should have a check box label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-checkboxes__label' })
      end
    end

    context 'check box hints' do
      let(:hint_text) { project_x.description }

      subject do
        builder.govuk_check_box(attribute, value, hint_text: hint_text)
      end

      specify 'should contain a hint with the correct text' do
        expect(subject).to have_tag('span', text: hint_text)
      end

      specify 'the hint should have the correct classes' do
        expect(subject).to have_tag('span', with: { class: %w(govuk-hint govuk-checkboxes__hint) })
      end
    end

    context 'multiple' do
      context 'default to multiple' do
        specify 'check box name should allow multiple values' do
          expect(subject).to have_tag('input', with: {
            type: 'checkbox',
            name: "#{object_name}[#{attribute}][]"
          })
        end
      end

      context 'overridden to false' do
        subject { builder.send(*args.push(multiple: false)) }

        specify 'check box name should allow a single value only' do
          expect(subject).to have_tag('input', with: {
            type: 'checkbox',
            name: "#{object_name}[#{attribute}]"
          })
        end
      end
    end

    context 'conditionally revealing content' do
      context 'when a block is given' do
        subject do
          builder.send(*args) do
            builder.govuk_text_field(:project_responsibilities)
          end
        end

        specify 'should include content provided in the block in a conditional div' do
          expect(subject).to have_tag('div', with: { class: 'govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden' }) do |cd|
            expect(cd).to have_tag('label', with: { class: 'govuk-label' }, text: 'Project_responsibilities')
            expect(cd).to have_tag('input', with: { type: 'text' })
          end
        end

        specify "the data-aria-controls attribute should match the conditional block's id" do
          input_data_aria_controls = parsed_subject.at_css("input[type='checkbox']")['data-aria-controls']
          conditional_id = parsed_subject.at_css('div.govuk-checkboxes__conditional')['id']
          expect(input_data_aria_controls).to eql(conditional_id)
        end

        specify 'conditional_id contains the object, attribute and value name' do
          expect(
            parsed_subject.at_css("input[type='checkbox']")['data-aria-controls']
          ).to eql("#{object_name}-#{attribute}-#{value}-conditional")
        end
      end

      context 'when no block is given' do
        subject { builder.send(*args) }

        specify "the data-aria-controls attribute should be blank" do
          input_data_aria_controls = parsed_subject.at_css("input[type='checkbox']")['data-aria-controls']
          expect(input_data_aria_controls).to be_nil
        end

        specify "the conditional container should not be present" do
          expect(subject).not_to have_tag('.govuk-checkboxes__conditional')
        end
      end
    end
  end
end
