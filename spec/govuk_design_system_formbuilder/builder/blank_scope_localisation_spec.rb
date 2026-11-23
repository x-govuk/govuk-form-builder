describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  after { GOVUKDesignSystemFormBuilder.reset! }

  let(:localisations) { { en: YAML.load_file('spec/support/locales/sample.en.yaml') } }

  context 'when the object name is blank' do
    let(:object_name) { '' }

    describe '#govuk_text_field' do
      let(:method) { :govuk_text_field }
      let(:attribute) { :name }
      let(:args) { [method, attribute] }
      subject { builder.send(*args) }

      it_behaves_like 'a field that supports setting the label via localisation'
      it_behaves_like 'a field that supports setting the label caption via localisation'
      it_behaves_like 'a field that supports setting the hint via localisation'

      specify 'should keep the field name flat' do
        expect(subject).to have_tag('input', with: { name: 'name' })
      end
    end

    describe '#govuk_radio_button' do
      include_context 'setup radios'

      let(:method) { :govuk_radio_button }
      let(:value) { :ballpoint_pen }
      let(:attribute) { :stationery }
      let(:args) { [method, attribute, value] }
      subject { builder.send(*args) }

      it_behaves_like 'a field that supports setting the label via localisation' do
        let(:attribute_override) { 'one-something-street' }
        let(:scope_override) { 'helpers.label.person.address.number_and_street_options' }
      end

      it_behaves_like 'a field that supports setting the hint via localisation' do
        let(:attribute_override) { 'one-something-street' }
        let(:scope_override) { 'helpers.hint.person.address.number_and_street_options' }
      end
    end

    describe '#govuk_collection_check_boxes' do
      let(:method) { :govuk_collection_check_boxes }
      let(:attribute) { :projects }
      let(:args) { [method, attribute, projects, :id, :name] }
      subject { builder.send(*args) }

      it_behaves_like 'a field that supports setting the legend via localisation'
      it_behaves_like 'a field that supports setting the legend caption via localisation'
    end

    context 'when the object has a namespaced model name' do
      let(:object) { Projects::Filter.new }
      let(:method) { :govuk_text_field }
      let(:attribute) { :search }
      let(:args) { [method, attribute] }
      subject { builder.send(*args) }

      context 'with nested localisation enabled' do
        specify 'should split the model name into nested keys' do
          with_localisations(localisations) do
            expect(subject).to have_tag('label', text: 'Search projects')
          end
        end
      end

      context 'with nested localisation disabled' do
        before do
          GOVUKDesignSystemFormBuilder.configure do |conf|
            conf.enable_nested_localisation = false
          end
        end

        specify 'should use the model name unchanged' do
          with_localisations(localisations) do
            expect(subject).to have_tag('label', text: 'Search all projects')
          end
        end
      end
    end

    context 'when the field is nested two levels deep' do
      subject do
        builder.fields_for(:address, builder: described_class) do |af|
          af.fields_for(:country, builder: described_class) { |cf| cf.govuk_text_field(:name) }
        end
      end

      specify 'should localise using the root object model name' do
        with_localisations(localisations) do
          expect(subject).to have_tag('label', text: 'Enter your country')
        end
      end
    end
  end

  shared_examples 'a field that is not localised' do
    let(:method) { :govuk_text_field }
    let(:attribute) { :name }
    let(:args) { [method, attribute] }
    subject { builder.send(*args) }

    specify 'should use the default label' do
      with_localisations(localisations) do
        expect(subject).to have_tag('label', text: 'Name')
      end
    end

    specify 'should not render a hint' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('div', with: { class: 'govuk-hint' })
      end
    end

    specify 'should not render a caption' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('span', with: { class: 'govuk-caption-m' })
      end
    end
  end

  context 'when the object name is not blank' do
    let(:object_name) { :guest }

    it_behaves_like 'a field that is not localised'
  end

  context 'when the object name is blank and there is no object' do
    let(:object_name) { '' }
    let(:object) { nil }

    it_behaves_like 'a field that is not localised'
  end

  context 'when the object name is blank and the object is false' do
    let(:object_name) { '' }
    let(:object) { false }

    it_behaves_like 'a field that is not localised'
  end

  context 'when the object name is blank and the object has no model name' do
    let(:object_name) { '' }
    let(:object) { Being.new }

    it_behaves_like 'a field that is not localised'
  end

  context 'when the object name is nil' do
    let(:object_name) { nil }

    it_behaves_like 'a field that is not localised'
  end

  context 'when the object name is nil and the field is nested' do
    let(:object_name) { nil }

    subject do
      builder.fields_for(:address, builder: described_class) { |af| af.govuk_text_field(:number_and_street) }
    end

    specify 'should not localise the nested field' do
      with_localisations(localisations) do
        expect(subject).not_to have_tag('label', text: /Enter your street address/)
      end
    end
  end
end
