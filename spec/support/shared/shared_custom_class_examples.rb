shared_examples 'a field that supports custom classes' do
  let(:block_content) { -> { %(You there, fill it up with petroleum distillate, and re-vulcanize my tires, post-haste!) } }
  subject { builder.send(*args, classes: custom_classes, &block_content) }

  context 'when classes are supplied in an array' do
    let(:custom_classes) { %w(custom-class--one custom-class--two) }

    specify "should have the custom classes" do
      expect(subject).to have_tag(element, with: { class: default_classes + custom_classes })
    end
  end

  context 'when classes are supplied in a string' do
    let(:custom_classes) { %(custom-class--one custom-class--two) }

    specify "should have the custom classes" do
      expect(subject).to have_tag(element, with: { class: default_classes + custom_classes.split })
    end
  end
end
