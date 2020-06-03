describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  include_context 'setup examples'

  describe '#govuk_collection_select' do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Cherished shade' }
    let(:hint_text) { 'The colour of your favourite handkerchief' }
    let(:method) { :govuk_collection_select }
    let(:args) { [method, attribute, colours, :id, :name] }
    subject { builder.send(*args) }

    let(:field_type) { 'select' }
    let(:aria_described_by_target) { 'select' }

    it_behaves_like 'a field that supports labels'
    it_behaves_like 'a field that supports captions on the label'
    it_behaves_like 'a field that supports labels as procs'

    it_behaves_like 'a field that supports hints'
    it_behaves_like 'a field that supports custom branding'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_identifier) { 'person-favourite-colour-error' }
      let(:error_class) { 'govuk-select--error' }
    end

    it_behaves_like 'a field that accepts arbitrary blocks of HTML' do
      let(:described_element) { 'select' }
    end

    it_behaves_like 'a field that supports setting the label via localisation'
    it_behaves_like 'a field that supports setting the hint via localisation'

    it_behaves_like 'a field that accepts a plain ruby object' do
      let(:described_element) { 'select' }
    end

    specify 'output should be a form group containing a label and select box' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('select')
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

    context 'extra attributes' do
      let(:extra_args) do
        {
          required: { provided: true, output: 'required' },
          autofocus: { provided: true, output: 'autofocus' }
        }
      end

      subject { builder.send(*args, html_options: extract_args(extra_args, :provided)) }

      specify 'select tag should have the extra attributes' do
        select_tag = parsed_subject.at_css('select')
        extract_args(extra_args, :output).each do |key, val|
          expect(select_tag[key]).to eql(val)
        end
      end
    end
  end
end
