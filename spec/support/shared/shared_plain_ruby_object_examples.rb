class Biscuit
  attr_accessor :name, :weight, :calories, :expires_on

  def initialize(name, weight, calories, expires_on = Date.today.next_year)
    self.name       = name
    self.weight     = weight
    self.calories   = calories
    self.expires_on = expires_on
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

shared_examples 'a date field that accepts a plain ruby object' do
  let(:object) { Biscuit.new('Rocky', 32, 184) }
  let(:object_name) { :biscuit }
  let(:attribute) { :expires_on }

  specify 'should render the element successfully' do
    expect(subject).to have_tag(*described_element)
  end
end
