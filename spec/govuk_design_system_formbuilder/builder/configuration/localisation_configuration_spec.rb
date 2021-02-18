describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  describe 'localisation config' do
    let(:args) { [method, attribute] }
    let(:attribute) { :name }
    let(:method) { :govuk_text_field }
    subject { builder.send(*args) }

    context 'with a custom fallback localisation schema root' do
      let(:localisations) { { en: YAML.load_file('spec/support/locales/custom_fallback.en.yaml') } }
      let(:label_text) { I18n.t(%i(my_shiny_new_app label widgets person name).join('.')) }

      before do
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.localisation_schema_fallback = %i(my_shiny_new_app __context__ widgets)
        end
      end

      specify 'should use the configured localisation fallback schema' do
        with_localisations(localisations) do
          expect(subject).to have_tag('label', text: label_text)
        end
      end
    end

    context 'with custom contextual localisation schema roots' do
      let(:localisations) { { en: YAML.load_file('spec/support/locales/custom_contexts.en.yaml') } }

      context 'labels' do
        let(:label_text) { I18n.t(%i(a long convoluted schema nested_far_far label too_inconsistently person name).join('.')) }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.localisation_schema_label = %i(a long convoluted schema nested_far_far __context__ too_inconsistently)
            conf.localisation_schema_fallback = %i(unused)
          end
        end

        specify 'should use the configured localisation schema for labels' do
          with_localisations(localisations) do
            expect(subject).to have_tag('label', text: label_text)
          end
        end
      end

      context 'hints' do
        let(:hint_text) { I18n.t(%i(a long convoluted schema hint nested_far_too_deeply person name).join('.')) }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.localisation_schema_hint = %i(a long convoluted schema __context__ nested_far_too_deeply)
            conf.localisation_schema_fallback = %i(unused)
          end
        end

        specify 'should use the configured localisation schema for hints' do
          with_localisations(localisations) do
            expect(subject).to have_tag('span', text: hint_text, with: { class: 'govuk-hint' })
          end
        end
      end

      context 'legends' do
        let(:attribute) { :projects }
        let(:method) { :govuk_collection_check_boxes }
        let(:legend_text) { I18n.t(%i(a long convoluted schema legend nested_far_too_deeply person projects).join('.')) }

        subject { builder.send(method, attribute, projects, :id, :name) }

        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.localisation_schema_legend = %i(a long convoluted schema __context__ nested_far_too_deeply)
            conf.localisation_schema_fallback = %i(unused)
          end
        end

        specify 'should use the configured localisation schema for legends' do
          with_localisations(localisations) do
            expect(subject).to have_tag('legend', text: legend_text, with: { class: 'govuk-fieldset__legend' })
          end
        end
      end
    end
  end
end
