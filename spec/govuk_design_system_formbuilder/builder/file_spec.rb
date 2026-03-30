describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_file_field' do
    let(:method) { :govuk_file_field }
    let(:attribute) { :photo }
    let(:label_text) { 'Upload an image' }
    let(:hint_text) { 'Only JPEGs are accepted' }

    let(:args) { [method, attribute] }
    let(:field_type) { 'input' }
    subject { builder.send(*args) }

    specify 'output should be a form group containing a file input and label' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        expect(subject).to have_tag('input', with: { type: 'file' })
        expect(subject).to have_tag('label')
      end
    end

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports labels'
    it_behaves_like 'a field that supports labels as procs'
    it_behaves_like 'a field that supports captions on the label'
    it_behaves_like 'a field that supports adding content before and after inputs'
    it_behaves_like 'a field that supports custom branding'
    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'input' }
    end

    it_behaves_like 'a field that supports hints' do
      let(:aria_described_by_target) { 'input' }
    end

    it_behaves_like 'a field that supports errors' do
      let(:object) { Person.new(photo: 'me.tiff') }
      let(:aria_described_by_target) { 'input' }

      let(:error_message) { /Must be a JPEG/ }
      let(:error_class) { 'govuk-file-upload--error' }
      let(:error_identifier) { 'person-photo-error' }
    end

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the label caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that allows extra HTML attributes to be set' do
      let(:described_element) { 'input' }
      let(:expected_class) { 'govuk-file-upload' }
    end

    it_behaves_like 'a field that allows nested HTML attributes to be set' do
      let(:described_element) { 'input' }
      let(:expected_class) { 'govuk-input' }
    end

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { ['input', { with: { type: 'file' } }] }
    end

    context "when the javascript flag is enabled" do
      subject { builder.send(*args, javascript: true) }

      specify "adds the JS enhancement markup" do
        expect(subject).to have_tag('div', with: { class: 'govuk-drop-zone', "data-module": "govuk-file-upload" }) do
          expect(subject).to have_tag('input', with: { type: 'file' })
        end
      end

      describe 'customising the component text elements' do
        let(:xpath_file_module_selector) { %(./div[@data-module="govuk-file-upload"]) }

        context "when no text customisation options are provided" do
          specify "the div has no i18n data attributes set" do
            expect(parsed_subject.at_css("div.govuk-drop-zone").attributes.keys).not_to include(/data-i18n/)
          end
        end

        context "when the choose files button text is customised" do
          subject { builder.send(*args, javascript: true, choose_files_button_text: custom_choose_files_button_text) }

          let(:choose_file_key) { "data-i18n.choose-files-button" }
          let(:custom_choose_files_button_text) { "Select a file" }

          specify "the div has the corresponding i18n data attribute set" do
            choose_files_button_attr = parsed_subject.at_css("div.govuk-drop-zone").attributes.fetch(choose_file_key).value

            expect(choose_files_button_attr).to eql(custom_choose_files_button_text)
          end
        end

        context "when the drop instruction text is customised" do
          subject { builder.send(*args, javascript: true, drop_instruction_text: custom_drop_instruction_text) }

          let(:drop_instruction_key) { "data-i18n.drop-instruction" }
          let(:custom_drop_instruction_text) { "or drop your file here" }

          specify "the div has the corresponding i18n data attribute set" do
            drop_instruction_attr = parsed_subject.at_css("div.govuk-drop-zone").attributes.fetch(drop_instruction_key).value

            expect(drop_instruction_attr).to eql(custom_drop_instruction_text)
          end
        end

        context "when the multiple files chosen text is customised" do
          subject { builder.send(*args, javascript: true, multiple_files_chosen_text: custom_multiple_files_chosen_text) }

          let(:multiple_files_chosen_key) { "data-i18n.multiple-files-chosen" }
          let(:custom_multiple_files_chosen_text) do
            {
              one: "%{count} file selected",
              other: "%{count} files selected"
            }
          end

          specify "the div has the corresponding i18n data attribute set" do
            attributes = parsed_subject.at_css("div.govuk-drop-zone").attributes
            expect(attributes.fetch("#{multiple_files_chosen_key}.one").value).to eql(custom_multiple_files_chosen_text[:one])
            expect(attributes.fetch("#{multiple_files_chosen_key}.other").value).to eql(custom_multiple_files_chosen_text[:other])
          end
        end

        context "when the no file chosen text is customised" do
          subject { builder.send(*args, javascript: true, no_file_chosen_text: custom_no_file_chosen_text) }

          let(:no_file_chosen_key) { "data-i18n.no-file-chosen" }
          let(:custom_no_file_chosen_text) { "No file selected" }

          specify "the div has the corresponding i18n data attribute set" do
            no_file_chosen_attr = parsed_subject.at_css("div.govuk-drop-zone").attributes.fetch(no_file_chosen_key).value

            expect(no_file_chosen_attr).to eql(custom_no_file_chosen_text)
          end
        end

        context "when the entered drop zone text is customised" do
          subject { builder.send(*args, javascript: true, entered_drop_zone_text: custom_entered_drop_zone_text) }

          let(:entered_drop_zone_key) { "data-i18n.entered-drop-zone" }
          let(:custom_entered_drop_zone_text) { "You have entered the drop zone" }

          specify "the div has the corresponding i18n data attribute set" do
            entered_drop_zone_attr = parsed_subject.at_css("div.govuk-drop-zone").attributes.fetch(entered_drop_zone_key).value

            expect(entered_drop_zone_attr).to eql(custom_entered_drop_zone_text)
          end
        end

        context "when the left drop zone text is customised" do
          subject { builder.send(*args, javascript: true, left_drop_zone_text: custom_left_drop_zone_text) }

          let(:left_drop_zone_key) { "data-i18n.left-drop-zone" }
          let(:custom_left_drop_zone_text) { "You have left the drop zone" }

          specify "the div has the corresponding i18n data attribute set" do
            left_drop_zone_attr = parsed_subject.at_css("div.govuk-drop-zone").attributes.fetch(left_drop_zone_key).value

            expect(left_drop_zone_attr).to eql(custom_left_drop_zone_text)
          end
        end
      end
    end
  end
end
