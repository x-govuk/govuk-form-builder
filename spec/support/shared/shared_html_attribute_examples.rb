shared_examples 'a field that allows extra HTML attributes to be set' do
  custom_attributes = {
    required:     { provided: true,              expected: 'required' },
    autocomplete: { provided: false,             expected: 'false' },
    placeholder:  { provided: 'Seymour Skinner', expected: 'Seymour Skinner' },
    data:         { provided: { a: 'b' },        expected: { 'data-a' => 'b' } },
    aria:         { provided: { c: 'd' },        expected: { 'aria-c' => 'd' } }
  }

  let(:custom_attributes) { custom_attributes }
  special_keys = %i(data aria)

  subject do
    builder.send(*args, **extract_args(custom_attributes, :provided))
  end

  describe 'input tag should have the extra attributes:' do
    extract_args(custom_attributes, :expected).each do |key, val|
      # we need to deal with the _special keys_, data and aria, separately
      # because Rails accepts them via a nested hash and automatically expands
      # them out; e.g,
      # tag.element(data: { a: 'b' }) will result in <element data-a="b" ...>
      if key.in?(special_keys)
        specify "#{val} is set" do
          val.each do |data_attribute_name, data_attribute_value|
            expect(subject).to have_tag(element, with: { data_attribute_name => data_attribute_value })
          end
        end
      else
        specify "#{key} is #{val}" do
          expect(subject).to have_tag(element, with: { key => val })
        end
      end
    end
  end
end
