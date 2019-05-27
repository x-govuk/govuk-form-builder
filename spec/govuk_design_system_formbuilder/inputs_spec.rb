require 'pry'
class TestHelper < ActionView::Base; end

class Person
  include ActiveModel::Model

  attr_accessor(:name, :born_on, :born_at, :gender, :over_18)
end

describe GOVUKDesignSystemFormBuilder::FormBuilder do

  let(:helper) { TestHelper.new }
  let(:object) { Person.new }
  let(:object_name) {:person}
  let(:builder) { described_class.new(object_name, object, helper, {})}
  let(:parsed_subject) { Nokogiri.parse(subject) }

  describe 'govuk_text_field' do
    let(:label) { 'Full name' }
    subject { builder.govuk_text_field(:name, label: label) }

    specify 'output should be form group containing a label and input' do
      expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
        expect(fg).to have_tag('label', text: label)
        expect(fg).to have_tag('input')
      end
    end

    specify 'the label should be associated with the input' do
      input_name = parsed_subject.at_css('input')['name']
      label_for = parsed_subject.at_css('label')['for']
      expect(input_name).to eql(label_for)
    end

    context 'when a hint is provided' do
      let(:hint) { "You'll find it on your passport" }
      subject { builder.govuk_text_field(:name, hint: hint) }

      specify 'output should contain a hint' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          expect(fg).to have_tag('span', text: hint, with: { class: 'govuk-hint' })
        end
      end

      specify 'output should also contain the label and input elements' do
        expect(subject).to have_tag('div', with: { class: 'govuk-form-group' }) do |fg|
          %w(label input).each { |element| expect(fg).to have_tag(element) }
        end
      end

      specify 'the hint should be associated with the input' do
        input_aria_describedby = parsed_subject.at_css('input')['aria-describedby']
        hint_id = parsed_subject.at_css('span.govuk-hint')['id']
        expect(input_aria_describedby).to eql(hint_id)
      end
    end

    context 'when a hint is not provided' do
      subject { builder.govuk_text_field(:name, hint: nil) }

      specify 'output should have no empty aria-describedby attribute' do
        expect(parsed_subject.at_css('span.govuk-hint')).not_to be_present
      end

      specify 'output should have no empty aria-describedby attribute' do
        expect(parsed_subject.at_css('input')['aria-describedby']).not_to be_present
      end
    end
  end
end
