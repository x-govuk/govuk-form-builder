describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  let(:field_type) { 'select' }
  let(:aria_described_by_target) { 'select' }
  let(:described_element) { 'select' }
  let(:expected_class) { 'govuk-select' }

  describe '#govuk_collection_select' do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Cherished shade' }
    let(:hint_text) { 'The colour of your favourite handkerchief' }
    let(:method) { :govuk_collection_select }
    let(:args) { [method, attribute, colours, :id, :name] }
    subject { builder.send(*args) }

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports labels'
    it_behaves_like 'a field that supports captions on the label'
    it_behaves_like 'a field that supports labels as procs'

    it_behaves_like 'a field that supports hints'
    it_behaves_like 'a field that supports custom branding'
    it_behaves_like 'a field that contains a customisable form group'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_identifier) { 'person-favourite-colour-error' }
      let(:error_class) { 'govuk-select--error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML'
    it_behaves_like 'a field that allows extra HTML attributes to be set'
    it_behaves_like 'a field that allows nested HTML attributes to be set'

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the label caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { 'select' }
    end

    specify 'output should be a form group containing a label and select box' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('select', with: { class: 'govuk-select' })
      end
    end

    specify 'select box should contain the correct number of options' do
      expect(subject).to have_tag('select > option', count: colours.size)
    end

    specify 'select box should contain the correct values and entries' do
      colours.each do |colour|
        expect(subject).to have_tag('select > option', text: colour.name, with: { value: colour.id })
      end
    end

    context 'preselecting an option' do
      # options are colours in this order: red, blue, green, yellow
      let(:selected_colour) { green_option }
      subject { builder.send(*args, options: { selected: selected_colour.id }) }

      specify %(should add a 'selected' attribute to the preselected option) do
        expect(subject).to have_tag('option', text: selected_colour.name, with: { selected: 'selected', value: selected_colour.id })
      end
    end

    # FIXME temporary only, ensure deprecation message is properly logged
    context 'when legacy html_options argument is provided' do
      subject { builder.send(*args, html_options: { data: { magic: true } }) }
      let(:logger) { Logger.new($stdout) }

      before { allow(Rails).to receive_message_chain(:logger, :warn) }
      before { subject }

      specify do
        expect(Rails.logger).to have_received(:warn).with(/html_options has been deprecated/)
      end
    end
  end

  describe "#govuk_select" do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Prized tint' }
    let(:hint_text) { 'The colour of your favourite cravat' }
    let(:method) { :govuk_select }
    let(:options_for_select) { colour_names }

    let(:args) { [method, attribute, options_for_select] }
    subject { builder.send(*args) }

    include_examples 'HTML formatting checks'

    it_behaves_like 'a field that supports labels'
    it_behaves_like 'a field that supports captions on the label'
    it_behaves_like 'a field that supports labels as procs'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_identifier) { 'person-favourite-colour-error' }
      let(:error_class) { 'govuk-select--error' }
    end

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the label caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the label caption via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that accepts a plain ruby object'
    it_behaves_like 'a field that allows extra HTML attributes to be set'
    it_behaves_like 'a field that allows nested HTML attributes to be set'

    specify 'a select element is rendered' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do
        with_tag('select', with: { class: "govuk-select" })
      end
    end

    specify 'the select element has the right options' do
      colour_names.each { |cn| expect(subject).to have_tag('select > option', with: { value: cn }, text: cn) }
    end

    context 'blocks' do
      let(:items) { %w(LemonChiffon PaleTurquoise FloralWhite Bisque) }

      let(:sample_block) do
        helper.safe_join(items.map { |web_colour| helper.tag.option(web_colour, value: web_colour) })
      end

      subject do
        builder.send(method, attribute) { sample_block }
      end

      specify 'the block content should be rendered inside the select element' do
        items.each do |web_colour|
          expect(subject).to have_tag('select > option', text: web_colour, with: { value: web_colour })
        end
      end
    end

    context 'options_for_select' do
      let(:items) { %w(Firebrick Peachpuff Honeydew Orhid) }

      let(:options_for_select) do
        helper.options_for_select(items.map { |web_colour| [web_colour, web_colour.downcase] })
      end

      subject do
        builder.send(method, attribute, options_for_select)
      end

      specify 'the options should be present in the select element' do
        items.each do |web_colour|
          expect(subject).to have_tag('select > option', text: web_colour, with: { value: web_colour.downcase })
        end
      end
    end

    context 'options_for_select with custom attributes' do
      let(:custom_data_attribute) { :hex }
      let(:options_for_select_with_attributes) do
        [
          ["PapayaWhip", "pw",  { data: { custom_data_attribute => "#ffefd5" } }],
          ["Chocolate", "choc", { data: { custom_data_attribute => "#d2691e" } }],
        ]
      end

      let(:options_for_select) { helper.options_for_select(options_for_select_with_attributes) }

      subject do
        builder.send(method, attribute, options_for_select_with_attributes)
      end

      specify 'the options with their custom attributes should be present in the select element' do
        expect(subject).to have_tag('select') do
          options_for_select_with_attributes.each do |colour_name, value, custom_attributes|
            with_tag(
              'option',
              text: colour_name,
              with: {
                :value => value,
                %(data-#{custom_data_attribute}) => custom_attributes.dig(:data, custom_data_attribute)
              }
            )
          end
        end
      end
    end

    context 'grouped_options_for_select' do
      let(:items) do
        {
          "Reds" => [%w(Tomato tomato), %w(Crimson crimson)],
          "Blues" => [%w(Navy navy), %w(PowderBlue powderblue)],
        }
      end

      let(:grouped_options_for_select) do
        helper.grouped_options_for_select(items)
      end

      subject do
        builder.send(method, attribute, grouped_options_for_select)
      end

      specify 'the options should be grouped in the correct optgroup' do
        items.each do |group, colours|
          expect(subject).to have_tag('select > optgroup', with: { label: group }) do
            colours.each { |name, value| with_tag('option', text: name, with: { value: value }) }
          end
        end
      end
    end
  end
end
