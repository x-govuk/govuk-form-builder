require_relative 'shared_text_field_examples'

class TestHelper < ActionView::Base; end

class Person
  include ActiveModel::Model

  attr_accessor(:name, :born_on, :born_at, :gender, :over_18, :favourite_colour)

  validates :name, presence: true
end

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

    specify 'select box should contain the correct options' do
      colours.each do |colour|
        expect(subject).to have_tag('select > option', text: colour.name, with: { value: colour.id } )
      end
    end

    context 'labelling' do
      subject { builder.send(method, attribute, colours, :id, :name, label: { text: label_text }) }

      specify 'the select box should be labelled correctly' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('label', text: label_text)
        end
      end
    end
  end
end
