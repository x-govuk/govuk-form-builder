describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe '#govuk_check_box' do
    let(:method) { :govuk_check_box }
    let(:attribute) { :stationery }
    let(:value) { ballpoint_pen.id }
    let(:value_with_dashes) { underscores_to_dashes(value) }
    let(:args) { [method, attribute, value] }

    subject { builder.send(*args) }

    specify 'output should contain a check box item group with a check box input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-checkboxes__item' }) do
        with_tag('input', with: {
          id: "person-stationery-#{value_with_dashes}-field",
          type: 'checkbox',
          value: value
        })
      end
    end

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports labels' do
      let(:label_text) { 'Writing implement' }
      let(:field_type) { "input[type='checkbox']" }

      specify 'the label should have a check box label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-checkboxes__label' })
      end
    end

    it_behaves_like 'a field that allows extra HTML attributes to be set' do
      let(:described_element) { 'input' }
      let(:value) { 'Montgomery Montgomery' }
      let(:expected_class) { 'govuk-checkboxes__input' }
    end

    it_behaves_like 'a field that allows nested HTML attributes to be set' do
      let(:described_element) { 'input' }
      let(:expected_class) { 'govuk-input' }
    end

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a fieldset item that can conditionally-reveal content' do
      subject do
        builder.send(*args) do
          builder.govuk_text_field(:stationery_choice)
        end
      end

      let(:fieldset_item_type) { 'checkboxes' }
      let(:fieldset_item_type_single) { 'checkbox' }
    end

    context 'labels set via procs' do
      let(:label_text) { 'Project Y' }
      let(:label_proc) { -> { label_text } }
      subject { builder.send(*args, label: label_proc) }

      specify 'the label should have a check box label class' do
        expect(subject).to have_tag('label', with: { class: 'govuk-checkboxes__label' })
      end

      specify %(the label's for attribute should match the checkbox's id) do
        label_for = parsed_subject.at_css('label')['for']
        checkbox_id = parsed_subject.at_css('input')['id']

        expect(label_for).to eql(checkbox_id)
      end
    end

    context 'check box hints' do
      let(:hint_text) { ballpoint_pen.description }

      subject do
        builder.send(*args, hint: { text: hint_text })
      end

      specify 'should contain a hint with the correct text' do
        expect(subject).to have_tag('span', text: hint_text)
      end

      specify 'the hint should have the correct classes' do
        expect(subject).to have_tag('span', with: { class: %w(govuk-hint govuk-checkboxes__hint) })
      end

      context 'when the hint is supplied in a proc' do
        subject do
          builder.govuk_check_box(attribute, value, hint: -> { builder.tag.section(project_x.description) })
        end

        specify 'the proc-supplied hint content should be present and contained in a div' do
          expect(subject).to have_tag('div', with: { class: %w(govuk-hint govuk-checkboxes__hint) }) do
            with_tag('section', text: project_x.description)
          end
        end
      end
    end

    context 'generating a hidden field for the unchecked value' do
      context 'when the unchecked_value is not provided' do
        specify 'the hidden field should not be present by default' do
          expect(subject).not_to have_tag('input', with: { type: 'hidden' })
        end
      end

      context %(unchecked values) do
        subject { builder.send(*args, '0') }

        [0, -1, 'nope'].each do |uv|
          context uv.to_s do
            subject { builder.send(*args, uv) }
            specify %(the hidden field value should be '#{uv}') do
              expect(subject).to have_tag('input', with: { type: 'hidden', value: uv })
            end
          end
        end
      end

      context 'when the unchecked_value is false' do
        subject { builder.send(*args, false) }

        specify %(the hidden field should not be present) do
          expect(subject).not_to have_tag('input', with: { type: 'hidden' })
        end
      end
    end

    describe 'multiple' do
      context 'default to multiple' do
        specify 'check box name should allow multiple values' do
          expect(subject).to have_tag('input', with: {
            type: 'checkbox',
            name: "#{object_name}[#{attribute}][]"
          })
        end
      end

      context 'overridden to false' do
        subject { builder.send(*args, multiple: false) }

        specify 'check box name should allow a single value only' do
          expect(subject).to have_tag('input', with: {
            type: 'checkbox',
            name: "#{object_name}[#{attribute}]"
          })
        end
      end
    end

    describe 'exclusive' do
      context 'default to non-exclusive' do
        specify 'check box should have no data behaviour attribute' do
          expect(subject).not_to have_tag('input', with: { type: 'checkbox', 'data-behaviour' => 'exclusive' })
        end
      end

      context 'when overriden to exclusive' do
        subject { builder.send(*args, exclusive: true) }

        specify %(check box should has a data behaviour attribute of 'exclusive') do
          expect(subject).to have_tag('input', with: { type: 'checkbox', 'data-behaviour' => 'exclusive' })
        end
      end

      context 'not clashing with other data attributes' do
        subject { builder.send(*args, exclusive: true, data: { index: '1234' }) }

        specify %(check box should has a data behaviour attribute of 'exclusive') do
          expect(subject).to have_tag(
            'input',
            with: {
              type: 'checkbox',
              'data-behaviour' => 'exclusive',
              'data-index' => '1234'
            }
          )
        end
      end
    end
  end
end
