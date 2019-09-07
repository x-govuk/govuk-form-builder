shared_examples 'a field that accepts arbitrary blocks of HTML' do
  let(:block_h1) { 'The quick brown fox' }
  let(:block_h2) { 'Jumped over the' }
  let(:block_p) { 'Lazy dog.' }

  let(:supplemental_id) { underscores_to_dashes([object_name, attribute, 'supplemental'].join('-')) }

  context 'when a block is supplied' do
    subject do
      builder.send(*args) do
        builder.safe_join(
          [builder.tag.h1(block_h1), builder.tag.h2(block_h2), builder.tag.p(block_p)]
        )
      end
    end

    specify 'should be associated with the containing element' do
      expect(subject).to have_tag(described_element, with: { 'aria-describedby' => supplemental_id })
    end

    specify 'should include block content wrapped in a div with correct supplemental id' do
      expect(subject).to have_tag('div', with: { id: supplemental_id }) do |sup|
        expect(sup).to have_tag('h1', text: block_h1)
        expect(sup).to have_tag('h2', text: block_h2)
        expect(sup).to have_tag('p', text: block_p)
      end
    end
  end

  context 'when no block is supplied' do
    subject { builder.send(*args) }

    specify 'should be no supplemental container' do
      expect(subject).not_to have_tag('div', with: { id: supplemental_id })
    end

    specify 'should be no association with the supplemental container' do
      expect(subject).not_to have_tag(described_element, with: { 'aria-describedby' => supplemental_id })
    end
  end
end
