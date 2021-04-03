shared_examples 'a field that allows extra HTML attributes to be set' do
  let(:example_block) { proc { builder.tag.span('block text') } }

  context 'with args in the expected formats' do
    custom_attributes = {
      required:     { provided: true,              expected: 'required' },
      autocomplete: { provided: false,             expected: 'false' },
      placeholder:  { provided: 'Seymour Skinner', expected: 'Seymour Skinner' },
      data:         { provided: { a: 'b' },        expected: { 'data-a' => 'b' } },
      aria:         { provided: { c: 'd' },        expected: { 'aria-c' => 'd' } },
      class:        { provided: %w(red spots),     expected: %w(red spots) }
    }

    let(:custom_attributes) { custom_attributes }

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

  context 'when classes are provided as a string' do
    let(:custom_classes) { "purple waves" }
    let(:combined_classes) { custom_classes.split.append(expected_class) }

    subject do
      builder.send(*args, class: custom_classes, &example_block)
    end

    specify 'the extra and default classes should both be present' do
      expect(parsed_subject).to contain_element(described_element).with_attribute('class').that_has_values(*combined_classes)
    end
  end
end

shared_examples 'a field that allows nested HTML attributes to be set' do
  let(:example_block) { proc { builder.tag.span('block text') } }

  context 'when aria-describedby is provided as a string' do
    let(:custom_aria_described_by) { "a-descriptive-paragraph-id" }
    let(:hint_args) { { hint: { text: "ignore this" } } }

    let(:generated_hint_id) do
      return nil if attribute.blank?

      [
        object_name,
        attribute,
        (defined?(value) && value),
        'hint'
      ].compact.map { |e| underscores_to_dashes(e) }.join("-")
    end

    let(:combined_aria_described_by) { custom_aria_described_by.split.append(generated_hint_id) }

    subject do
      builder.send(*args, aria: { describedby: custom_aria_described_by }, **hint_args, &example_block)
    end

    specify 'the aria-describedby should both be present' do
      expect(parsed_subject).to contain_element(described_element).with_attribute("aria-describedby").that_has_values(custom_aria_described_by, generated_hint_id)
    end
  end
end
