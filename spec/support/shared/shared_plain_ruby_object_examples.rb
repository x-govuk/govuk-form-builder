class Biscuit
  attr_accessor :name, :weight, :calories

  def initialize(name, weight, calories)
    self.name     = name
    self.weight   = weight
    self.calories = calories
  end
end

shared_examples 'a field that accepts a plain ruby object' do
  let(:object) { Biscuit.new('Pick-up!', 28, 143) }
  let(:object_name) { :biscuit }
  let(:attribute) { :calories }

  specify 'should render the element successfully' do
    expect(subject).to have_tag(*described_element)
  end
end
