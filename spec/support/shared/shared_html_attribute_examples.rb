shared_examples 'a field that allows extra HTML attributes to be set' do
  let(:example_block) { proc { builder.tag.span('block text') } }

  context 'with args in the expected formats' do
    sample_json = { e: 'f', g: %w(h i j) }.to_json
    custom_attributes = {
      required:     { provided: true,                    expected: 'required' },
      autocomplete: { provided: false,                   expected: 'false' },
      placeholder:  { provided: 'Seymour Skinner',       expected: 'Seymour Skinner' },
      class:        { provided: %w(red spots),           expected: %w(red spots) },
      value:        { provided: 'Montgomery Montgomery', expected: 'Montgomery Montgomery' },

      data: {
        provided: {
          a: 'b',
          c: 'd',
          json: sample_json,
        },
        expected: {
          'data-a'    => 'b',
          'data-c'    => 'd',
          'data-json' => sample_json,
        }
      },
      aria: {
        provided: {
          # these mergeable items all accept lists of values that are space
          # separated strings (e.g., aria-controls: "item-a item-b") so should
          # be deeply-merged with attributes generated by the form builder.
          #
          # Any duplicate values will be repeated in this proces.
          #
          # see: GOVUKDesignSystemFormbuilder::Traits::HTMLAttributes::Attributes::MERGEABLE)
          controls: 'Risotto Risotto',
          describedby: 'Wolfcastle Wolfcastle',
          flowto: 'McClure McClure',
          labelledby: 'Spuckler Spuckler',
          owns: 'Muntz Muntz',

          # aria-label is a special case, along with value it should not be
          # treated like a list when deep merging
          label: 'Burns Burns',

        },
        expected: {
          'aria-label' => 'Burns Burns',

          'aria-controls' => 'Risotto',
          'aria-describedby' => 'Wolfcastle',
          'aria-flowto' => 'McClure',
          'aria-labelledby' => 'Spuckler',
          'aria-owns' => 'Muntz',
        }
      },
    }

    let(:custom_attributes) { custom_attributes }

    special_keys = %i(data aria)

    subject do
      builder.send(*args, **extract_args(custom_attributes, :provided), &example_block)
    end

    describe 'input tag should have the extra attributes:' do
      extract_args(custom_attributes, :expected).each do |key, val|
        case
        when key == :value
          specify "#{key} has classes #{val}" do
            if described_element == "textarea"
              expect(subject).to have_tag(described_element, text: /#{val}/)
            else
              expect(subject).to have_tag(described_element, with: { key => val })
            end
          end

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
              expect(parsed_subject.at_css(described_element)[data_attribute_name]).to match(data_attribute_value)
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

  context 'when an empty string is provided' do
    let(:data_attribute) { 'importance' }
    subject do
      builder.send(*args, data: { data_attribute => "" })
    end

    specify 'no attribute should be present' do
      expect(parsed_subject.at_css(described_element).attributes).not_to have_key("data-#{data_attribute}")
    end
  end
end
