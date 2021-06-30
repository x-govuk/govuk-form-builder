describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe '#govuk_check_boxes_fieldset' do
    let(:attribute) { :projects }
    let(:method) { :govuk_check_boxes_fieldset }
    let(:field_type) { 'input' }
    let(:kwargs) { {} }
    let(:aria_described_by_target) { 'fieldset' }
    let(:args) { [method, attribute] }

    let(:example_block) do
      proc do
        builder.safe_join(
          projects.map do |p|
            builder.govuk_check_box(attribute, p.id)
          end
        )
      end
    end

    subject { builder.send(*args, **kwargs, &example_block) }

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Select at least one project/ }
      let(:error_class) { nil }
      let(:error_identifier) { 'person-projects-error' }
    end

    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports custom classes' do
      let(:element) { 'div' }
      let(:default_classes) { %w(govuk-checkboxes) }
    end

    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that supports setting the hint via localisation'
    it_behaves_like 'a field that supports localised fieldset hints' do
      let(:localisation_key) { :projects_options }
      let(:field_name_selector) { "projects" }
    end
    it_behaves_like 'a field that supports setting the legend via localisation'

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { 'fieldset' }
    end

    it_behaves_like 'a fieldset that expects arbitrary blocks of HTML'

    context 'when a caption is supplied' do
      let(:caption_text) { 'Personal preferences' }
      let(:caption_size) { 'l' }
      let(:caption) { { text: caption_text, size: caption_size } }
      let(:caption_class) { "govuk-caption-#{caption_size}" }

      subject do
        builder.send(*args, legend: legend, caption: caption, &example_block)
      end

      context 'with a legend' do
        let(:legend_text) { 'Favourite colour?' }
        let(:legend) { { text: legend_text } }

        specify 'output should contain a correctly-positioned caption with the right content' do
          expect(subject).to have_tag('fieldset', with: { class: %w(govuk-fieldset) }) do
            with_tag('span', text: caption_text, with: { class: caption_class })
          end
        end
      end

      context 'without a legend' do
        let(:legend) { nil }

        specify 'output should contain no caption at all' do
          expect(subject).not_to have_tag('span', with: { class: caption_class })
        end
      end
    end

    context 'when a block containing check boxes is supplied' do
      specify 'output should be a form group containing a form group and fieldset' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
          with_tag('fieldset', with: { class: 'govuk-fieldset' })
        end
      end

      specify 'output should contain check boxes' do
        expect(subject).to have_tag('div', with: { class: 'govuk-checkboxes', 'data-module' => 'govuk-checkboxes' }) do
          expect(subject).to have_tag('input', with: { type: 'checkbox' }, count: 3)
        end
      end

      context 'multiple options' do
        specify 'there should be a hidden field to represent deselection' do
          expected_name = %(#{object_name}[#{attribute}][])

          expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
            with_tag('input', with: { type: 'hidden', name: expected_name })
          end
        end
      end

      context 'single option' do
        let(:kwargs) { { multiple: false } }

        specify 'no hidden field should be present' do
          expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
            without_tag('input', with: { type: 'hidden' })
          end
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

      context 'dividers' do
        subject do
          builder.send(*args) do
            builder.govuk_check_box_divider
          end
        end

        specify "should output a 'or' divider by default" do
          expect(subject).to have_tag('div', text: 'or', with: { class: %w(govuk-checkboxes__divider) })
        end

        context 'when divider text overridden' do
          let(:other_text) { 'alternatively' }
          subject do
            builder.send(method, attribute) do
              builder.govuk_check_box_divider(other_text)
            end
          end

          specify "should output a divider containing the supplied text" do
            expect(subject).to have_tag('div', text: other_text, with: { class: %w(govuk-checkboxes__divider) })
          end
        end
      end
    end
  end
end
