shared_examples 'a field that supports custom branding' do
  let(:default_brand) { 'govuk' }
  let(:custom_brand) { 'globex-corp' }

  before do
    GOVUKDesignSystemFormBuilder.configure do |conf|
      conf.brand = custom_brand
    end
  end

  after { GOVUKDesignSystemFormBuilder.reset! }

  specify 'should contain the custom branding' do
    expect(subject).to match(Regexp.new(custom_brand))
  end

  specify 'should not contain any default branding' do
    expect(subject).not_to match(Regexp.new(default_brand))
  end
end

shared_examples 'a field that allows branding to be explicitly overriden' do
  let(:custom_brand) { 'globex-corp' }
  let(:default_brand) { 'govuk' }

  subject { builder.send(*args, brand: custom_brand) }

  specify 'should contain the custom branding' do
    expect(subject).to match(Regexp.new(custom_brand))
  end

  specify 'should not contain any default branding' do
    expect(subject).not_to match(Regexp.new(default_brand))
  end
end
