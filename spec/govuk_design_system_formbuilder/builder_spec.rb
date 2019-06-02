require_relative 'shared_text_field_examples'

describe GOVUKDesignSystemFormBuilder::FormBuilder do
  let(:helper) { TestHelper.new }
  let(:object) { Person.new }
  let(:object_name) { :person }
  let(:builder) { described_class.new(object_name, object, helper, {}) }
  let(:parsed_subject) { Nokogiri.parse(subject) }

  describe('#govuk_text_field')   { it_behaves_like 'a regular input', 'text' }
  describe('#govuk_tel_field')    { it_behaves_like 'a regular input', 'tel' }
  describe('#govuk_email_field')  { it_behaves_like 'a regular input', 'email' }
  describe('#govuk_url_field')    { it_behaves_like 'a regular input', 'url' }
  describe('#govuk_number_field') { it_behaves_like 'a regular input', 'number' }

  describe '#govuk_collection_select' do
    let(:attribute) { :favourite_colour }
    let(:label_text) { 'Cherished shade' }
    let(:method) { :govuk_collection_select }
    let(:colours) do
      [
        OpenStruct.new(id: 'red', name: 'Red'),
        OpenStruct.new(id: 'blue', name: 'Blue'),
        OpenStruct.new(id: 'green', name: 'Green'),
        OpenStruct.new(id: 'yellow', name: 'Yellow')
      ]
    end

    subject { builder.send(method, attribute, colours, :id, :name) }

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

    context 'labelling' do
      subject { builder.send(method, attribute, colours, :id, :name, label: { text: label_text }) }

      specify 'the select box should be labelled correctly' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('label', text: label_text)
        end
      end

      specify 'the label should be associated with the input' do
        input_name = parsed_subject.at_css('select')['name']
        label_for = parsed_subject.at_css('label')['for']
        expect(input_name).to eql(label_for)
      end
    end

    context 'when a hint is provided' do
      let(:hint) { 'The colour of your favourite handkerchief' }
      subject { builder.send(method, attribute, colours, :id, :name, hint: { text: hint }) }

      specify 'output should contain a hint' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('span', text: hint, with: { class: 'govuk-hint' })
        end
      end

      specify 'output should also contain the label and select elements' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          %w(label select).each { |element| expect(fg).to have_tag(element) }
        end
      end

      specify 'the hint should be associated with the input' do
        select_aria_describedby = parsed_subject.at_css('select')['aria-describedby']
        hint_id = parsed_subject.at_css('span.govuk-hint')['id']
        expect(select_aria_describedby).to eql(hint_id)
      end
    end

    context 'extra attributes' do
      let(:extra_args) do
        {
          required: { provided: true, output: 'required' },
          autofocus: { provided: true, output: 'autofocus' }
        }
      end

      subject { builder.send(method, attribute, colours, :id, :name, html_options: extract_args(extra_args, :provided)) }

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
        builder.send(method, attribute, colours, :id, :name) do
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
