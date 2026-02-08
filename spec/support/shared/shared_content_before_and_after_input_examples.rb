shared_examples 'a field that supports adding content before and after inputs' do
  # let(:before_key) { defined?(before_inputs) ? before_inputs : :before_input }
  # let(:after_key) { defined?(after_inputs) ? after_inputs : :after_input }
  let(:before_key) do
    if defined?(multiple_inputs) && multiple_inputs
      :before_inputs
    else
      :before_input
    end
  end

  let(:after_key) do
    if defined?(multiple_inputs) && multiple_inputs
      :after_inputs
    else
      :after_input
    end
  end

  context 'when text is added before the input' do
    subject do
      builder.send(*args, before_key => 'Pre')
    end

    specify 'the content is included' do
      expect(subject).to match('Pre')
    end

    specify 'the content is before the element' do
      expect(subject).to match(/Pre.*<#{field_type}/)
    end
  end

  context 'when text is added after the input' do
    subject { builder.send(*args, after_key => 'Post') }

    specify 'the content is included' do
      expect(subject).to match('Post')
    end

    specify 'the content is after the element' do
      case field_type
      when 'select'
        expect(subject).to match(%r{</#{field_type}>.*Post})
      else
        expect(subject).to match(%r{<#{field_type}.*Post})
      end
    end
  end
end
