describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe "textarea" do
    let(:method) { :govuk_text_area }
    let(:attribute) { :cv }
    let(:args) { [method, attribute] }
    let(:kwargs) { {} }
    let(:form_group) { parsed_subject.at_css('div.govuk-form-group') }

    let(:characters_under_limit_other_text) { 'Hai %{count} caratteri rimanenti' }
    let(:characters_under_limit_one_text) { 'Ti rimane %{count} carattere' }
    let(:characters_at_limit_text) { 'Hai 0 caratteri rimanenti' }
    let(:characters_over_limit_other_text) { 'Hai %{count} caratteri di troppo' }
    let(:characters_over_limit_one_text) { 'Hai %{count} carattere di troppo' }

    let(:words_under_limit_other_text) { 'Hai %{count} parole rimanenti' }
    let(:words_under_limit_one_text) { 'Ti rimane %{count} parola' }
    let(:words_at_limit_text) { 'Hai 0 parole rimanenti' }
    let(:words_over_limit_other_text) { 'Hai %{count} parole di troppo' }
    let(:words_over_limit_one_text) { 'Hai %{count} parola di troppo' }

    subject { builder.send(*args, **kwargs) }

    context 'when the config is default' do
      specify 'no data i18n attributes are set' do
        data_attribute_keys = form_group.attributes.keys.select { |a| a =~ /data-i18n/ }

        expect(data_attribute_keys).to be_empty
      end
    end

    context 'when not limiting anything' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_text_area_characters_under_limit_other_text = 'abc'
        end
      end

      specify 'no data i18n attributes are set' do
        data_attribute_keys = form_group.attributes.keys.select { |a| a =~ /data-i18n/ }

        expect(data_attribute_keys).to be_empty
      end
    end

    context 'when limiting is enabled and data i18n attributes are localised in the config' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_text_area_description_text = nil
          conf.default_text_area_characters_under_limit_other_text = characters_under_limit_other_text
          conf.default_text_area_characters_under_limit_one_text = characters_under_limit_one_text
          conf.default_text_area_characters_at_limit_text = characters_at_limit_text
          conf.default_text_area_characters_over_limit_other_text = characters_over_limit_other_text
          conf.default_text_area_characters_over_limit_one_text = characters_over_limit_one_text
          conf.default_text_area_words_under_limit_other_text = words_under_limit_other_text
          conf.default_text_area_words_under_limit_one_text = words_under_limit_one_text
          conf.default_text_area_words_at_limit_text = words_at_limit_text
          conf.default_text_area_words_over_limit_other_text = words_over_limit_other_text
          conf.default_text_area_words_over_limit_one_text = words_over_limit_one_text
        end
      end

      context 'for characters' do
        let(:kwargs) { { max_chars: 20 } }

        specify 'the character data i18n attributes are localised in the markup' do
          aggregate_failures do
            expect(form_group.attributes['data-i18n.characters-under-limit.other'].text).to eql(characters_under_limit_other_text)
            expect(form_group.attributes['data-i18n.characters-under-limit.one'].text).to eql(characters_under_limit_one_text)
            expect(form_group.attributes['data-i18n.characters-at-limit'].text).to eql(characters_at_limit_text)
            expect(form_group.attributes['data-i18n.characters-over-limit.other'].text).to eql(characters_over_limit_other_text)
            expect(form_group.attributes['data-i18n.characters-over-limit.one'].text).to eql(characters_over_limit_one_text)
          end
        end

        specify 'the word data i18n attributes are not localised in the markup' do
          data_attribute_keys = form_group.attributes.keys.select { |a| a.start_with?('data-i18n.word') }

          expect(data_attribute_keys).to be_empty
        end
      end

      context 'for words' do
        let(:kwargs) { { max_words: 20 } }

        specify 'the word data i18n attributes are localised in the markup' do
          aggregate_failures do
            expect(form_group.attributes['data-i18n.words-under-limit.other'].text).to eql(words_under_limit_other_text)
            expect(form_group.attributes['data-i18n.words-under-limit.one'].text).to eql(words_under_limit_one_text)
            expect(form_group.attributes['data-i18n.words-at-limit'].text).to eql(words_at_limit_text)
            expect(form_group.attributes['data-i18n.words-over-limit.other'].text).to eql(words_over_limit_other_text)
            expect(form_group.attributes['data-i18n.words-over-limit.one'].text).to eql(words_over_limit_one_text)
          end
        end

        specify 'the character data i18n attributes are not localised in the markup' do
          data_attribute_keys = form_group.attributes.keys.select { |a| a.start_with?('data-i18n.character') }

          expect(data_attribute_keys).to be_empty
        end
      end
    end
  end

  describe 'file upload' do
    let(:method) { :govuk_file_field }
    let(:attribute) { :photo }
    let(:args) { [method, attribute] }
    let(:kwargs) { { javascript: true } }
    let(:drop_zone) { parsed_subject.at_css('div.govuk-drop-zone') }

    let(:default_file_choose_files_button_text) { 'Scegli file' }
    let(:default_file_drop_instruction_text) { 'o trascina il file' }
    let(:default_file_no_file_chosen_text) { 'Nessun file selezionato' }
    let(:default_file_multiple_files_chosen_one_text) { '%{count} file selezionato' }
    let(:default_file_multiple_files_chosen_other_text) { '%{count} file selezionati' }
    let(:default_file_entered_drop_zone) { 'Area di rilascio inserita' }
    let(:default_file_left_drop_zone) { 'Area di rilascio abbandonata' }

    subject { builder.send(*args, **kwargs) }

    context 'when the config is default' do
      specify 'no data i18n attributes are localised in the markup' do
        data_attribute_keys = drop_zone.attributes.keys.select { |a| a =~ /data-i18n/ }

        expect(data_attribute_keys).to be_empty
      end
    end

    context 'when default strings are localised in the config' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_file_choose_files_button_text = default_file_choose_files_button_text
          conf.default_file_drop_instruction_text = default_file_drop_instruction_text
          conf.default_file_no_file_chosen_text = default_file_no_file_chosen_text
          conf.default_file_multiple_files_chosen_one_text = default_file_multiple_files_chosen_one_text
          conf.default_file_multiple_files_chosen_other_text = default_file_multiple_files_chosen_other_text
          conf.default_file_entered_drop_zone = default_file_entered_drop_zone
          conf.default_file_left_drop_zone = default_file_left_drop_zone
        end
      end

      specify 'the character data i18n attributes are localised in the markup' do
        aggregate_failures do
          expect(drop_zone.attributes['data-i18n.choose-files-button'].text).to eql(default_file_choose_files_button_text)
          expect(drop_zone.attributes['data-i18n.drop-instruction'].text).to eql(default_file_drop_instruction_text)
          expect(drop_zone.attributes['data-i18n.no-file-chosen'].text).to eql(default_file_no_file_chosen_text)
          expect(drop_zone.attributes['data-i18n.multiple-files-chosen.one'].text).to eql(default_file_multiple_files_chosen_one_text)
          expect(drop_zone.attributes['data-i18n.multiple-files-chosen.other'].text).to eql(default_file_multiple_files_chosen_other_text)
          expect(drop_zone.attributes['data-i18n.entered-drop-zone'].text).to eql(default_file_entered_drop_zone)
          expect(drop_zone.attributes['data-i18n.left-drop-zone'].text).to eql(default_file_left_drop_zone)
        end
      end
    end
  end

  describe 'password input' do
    let(:method) { :govuk_password_field }
    let(:attribute) { :password }
    let(:args) { [method, attribute] }
    let(:form_group) { parsed_subject.at_css('div.govuk-form-group') }

    let(:default_show_password_text) { 'Mostra' }
    let(:default_hide_password_text) { 'Nascondi' }
    let(:default_show_password_aria_label_text) { 'Mostra password' }
    let(:default_hide_password_aria_label_text) { 'Nascondi password' }
    let(:default_password_shown_announcement_text) { 'La tua password è visibile' }
    let(:default_password_hidden_announcement_text) { 'La tua password è nascosta' }

    subject { builder.send(*args) }

    context 'when the config is default' do
      specify 'no data i18n attributes are set' do
        data_attribute_keys = form_group.attributes.keys.select { |a| a =~ /data-i18n/ }

        expect(data_attribute_keys).to be_empty
      end
    end

    context 'when default strings are localised in the config' do
      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.default_show_password_text = default_show_password_text
          conf.default_hide_password_text = default_hide_password_text
          conf.default_show_password_aria_label_text = default_show_password_aria_label_text
          conf.default_hide_password_aria_label_text = default_hide_password_aria_label_text
          conf.default_password_shown_announcement_text = default_password_shown_announcement_text
          conf.default_password_hidden_announcement_text = default_password_hidden_announcement_text
        end
      end

      specify 'the character data i18n attributes are localised in the markup' do
        aggregate_failures do
          expect(form_group.attributes['data-i18n.show-password'].text).to eql(default_show_password_text)
          expect(form_group.attributes['data-i18n.hide-password'].text).to eql(default_hide_password_text)
          expect(form_group.attributes['data-i18n.show-password-aria-label'].text).to eql(default_show_password_aria_label_text)
          expect(form_group.attributes['data-i18n.hide-password-aria-label'].text).to eql(default_hide_password_aria_label_text)
          expect(form_group.attributes['data-i18n.password-shown-announcement'].text).to eql(default_password_shown_announcement_text)
          expect(form_group.attributes['data-i18n.password-hidden-announcement'].text).to eql(default_password_hidden_announcement_text)
        end
      end
    end
  end
end
