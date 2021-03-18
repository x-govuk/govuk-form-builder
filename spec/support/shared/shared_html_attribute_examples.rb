shared_examples 'a field that allows extra HTML attributes to be set' do
  custom_attributes = {
    required:     { provided: true,              expected: 'required' },
    autocomplete: { provided: false,             expected: 'false' },
    placeholder:  { provided: 'Seymour Skinner', expected: 'Seymour Skinner' },
    data:         { provided: { a: 'b' },        expected: { 'data-a' => 'b' } },
    aria:         { provided: { c: 'd' },        expected: { 'aria-c' => 'd' } },
    class:        { provided: %w(red spots),     expected: %w(red spots) }
  }

  let(:custom_attributes) { custom_attributes }

  let(:example_block) { proc { builder.tag.span('block text') } }
  special_keys = %i(data aria)

  subject do
    builder.send(*args, **extract_args(custom_attributes, :provided), &example_block)
  end

  describe 'input tag should have the extra attributes:' do
    extract_args(custom_attributes, :expected).each do |key, val|
      case

      # class is dealt with as a special case because we want to ensure that whatever
      # extra classes we provide are *added* to the pre-existing one (expected_class)
      # instead of replacing it
      when key == :class
        specify "#{key} has classes #{val}" do
          expect(subject).to have_tag(described_element, with: { class: val.concat(Array.wrap(expected_class)) })
        end

      # we need to deal with the _special keys_, data and aria, separately
      # because Rails accepts them via a nested hash and automatically expands
      # them out; e.g,
      # tag.element(data: { a: 'b' }) will result in <element data-a="b" ...>
      when key.in?(special_keys)
        specify "#{val} is set" do
          val.each do |data_attribute_name, data_attribute_value|
            expect(subject).to have_tag(described_element, with: { data_attribute_name => data_attribute_value })
          end
        end

      # all others, just check that the attribute has been set properly
      else
        specify "#{key} is #{val}" do
          expect(subject).to have_tag(described_element, with: { key => val })
        end
      end
    end
  end
end
