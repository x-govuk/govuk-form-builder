require_relative 'shared_text_field_examples'

class TestHelper < ActionView::Base; end

class Person
  include ActiveModel::Model

  attr_accessor(:name, :born_on, :born_at, :gender, :over_18)

  validates :name, presence: true
end

describe GOVUKDesignSystemFormBuilder::FormBuilder do
  describe '#govuk_text_field' do
    it_behaves_like 'a regular input', 'text'
  end

  describe '#govuk_tel_field' do
    it_behaves_like 'a regular input', 'tel'
  end
end
