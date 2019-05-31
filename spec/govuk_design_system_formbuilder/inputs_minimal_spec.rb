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

  let(:attribute) { :name }
  let(:label_text) { 'Full name' }
  let(:method) { "govuk_text_field".to_sym }

  subject { builder.send(method, :name, label: { text: label_text }) }

  specify "output should have the correct type of text" do
    input_type = parsed_subject.at_css('input')['type']
    expect(input_type).to eql('text')
  end
end
