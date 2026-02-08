shared_examples 'a field that accepts arbitrary blocks of HTML' do
  let(:block_h1) { 'The quick brown fox' }
  let(:block_h2) { 'Jumped over the' }
  let(:block_p) { 'Lazy dog.' }

  context 'when a block is supplied' do
    subject do
      builder.send(*args) do
        builder.safe_join(
          [builder.tag.h1(block_h1), builder.tag.h2(block_h2), builder.tag.p(block_p)]
        )
      end
    end

    specify 'should include block content wrapped in a div' do
      expect(subject).to have_tag('div') do
        with_tag('h1', text: block_h1)
        with_tag('h2', text: block_h2)
        with_tag('p', text: block_p)
      end
    end
  end
end

shared_examples 'a fieldset that expects arbitrary blocks of HTML' do
  context 'when no block is supplied' do
    subject { builder.send(*args) }

    specify { expect { subject }.to raise_error(LocalJumpError, /no block given/) }
  end

  context 'when block is supplied' do
    subject { builder.send(*args, &example_block) }

    let(:example_block) { proc { '<b>some content</b>' } }

    specify { expect { subject }.not_to raise_error }
    specify { expect { |b| builder.send(*args, &b) }.to yield_control.once }

    context 'with render' do
      let(:example_block) { proc { helper.render(html: '<b>rendered</b>') } }

      before { allow(helper).to receive(:render) }
      before { subject }

      specify { expect(helper).to have_received(:render).once }
    end
  end
end
