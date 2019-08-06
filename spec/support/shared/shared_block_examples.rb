shared_examples 'a field that accepts arbitrary blocks of HTML' do
  let(:block_h1) { 'The quick brown fox' }
  let(:block_h2) { 'Jumped over the' }
  let(:block_p) { 'Lazy dog.' }
  subject do
    builder.send(*args) do
      builder.safe_join(
        [
          builder.tag.h1(block_h1),
          builder.tag.h2(block_h2),
          builder.tag.p(block_p)
        ]
      )
    end
  end

  specify 'should include block content' do
    expect(subject).to have_tag('h1', text: block_h1)
    expect(subject).to have_tag('h2', text: block_h2)
    expect(subject).to have_tag('p', text: block_p)
  end
end
