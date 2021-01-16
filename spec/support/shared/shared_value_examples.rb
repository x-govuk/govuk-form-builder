shared_examples 'a collection field that supports setting the value via a proc with symbols' do
  let(:args) { [method, attribute, stationery, ->(item) { item }, ->(item) { item.capitalize }] }

  context 'when the values are symbols' do
    specify 'the values should be present' do
      stationery.each { |item| expect(subject).to have_tag("input", with: { value: item.to_s }) }
    end

    specify 'the label should be present' do
      stationery.each do |item|
        expect(subject).to have_tag("label", text: item.to_s.capitalize, with: { for: %(person-favourite-colour-#{item}-field) })
      end
    end
  end
end

shared_examples 'a collection field that supports setting the value via a proc with strings' do
  context 'when the values are strings' do
    let(:stationery) { %w(pencil pen eraser paperclip) }

    specify 'the values should be present' do
      stationery.each { |item| expect(subject).to have_tag("input", with: { value: item.to_s }) }
    end

    specify 'the label should be present' do
      stationery.each do |item|
        expect(subject).to have_tag("label", text: item.to_s.capitalize, with: { for: %(person-favourite-colour-#{item}-field) })
      end
    end
  end
end

shared_examples 'a collection field that supports setting the value via a proc' do
  prefix = 'a collection field that supports setting the value via a proc'
  stationery = %w(pencil pen eraser paperclip)

  include_examples(%(#{prefix} with strings)) { let(:stationery) { stationery } }
  include_examples(%(#{prefix} with symbols)) { let(:stationery) { stationery.map(&:to_sym) } }
end
