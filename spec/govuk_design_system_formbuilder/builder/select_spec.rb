describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe '#govuk_collection_select' do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Cherished shade' }
    let(:hint_text) { 'The colour of your favourite handkerchief' }
    let(:method) { :govuk_collection_select }
    let(:colours) do
      [
        OpenStruct.new(id: 'red', name: 'Red'),
        OpenStruct.new(id: 'blue', name: 'Blue'),
        OpenStruct.new(id: 'green', name: 'Green'),
        OpenStruct.new(id: 'yellow', name: 'Yellow')
      ]
    end
    let(:args) { [method, attribute, colours, :id, :name] }
    subject { builder.send(*args) }

    let(:field_type) { 'select' }
    let(:aria_described_by_target) { 'select' }

    it_behaves_like 'a field that supports labels'

    it_behaves_like 'a field that supports hints'

    it_behaves_like 'a field that supports errors' do
      let(:error_message) { /Choose a favourite colour/ }
      let(:error_identifier) { 'person-favourite-colour-error' }
      let(:error_class) { nil }
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

      subject { builder.send(*args.push(html_options: extract_args(extra_args, :provided))) }

      specify 'input tag should have the extra attributes' do
        input_tag = parsed_subject.at_css('select')
        extract_args(extra_args, :output).each do |key, val|
          expect(input_tag[key]).to eql(val)
        end
      end
    end

    context 'when passed a block' do
      let(:block_h1) { 'The quick brown fox' }
      let(:block_h2) { 'Jumped over the' }
      let(:block_p) { 'Lazy dog.' }
      subject do
        builder.send(*args) do
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
  end
end
