shared_examples 'an error summary linking directly to a form element' do |method, element|
  let(:identifier) { 'person-name-field-error' }
  let(:element) { element || 'input' }

  let(:object) { Person.new(name: nil) }
  subject do
    builder.capture do
      builder.safe_join(
        [
          builder.govuk_error_summary,
          builder.send(method, :name)
        ]
      )
    end
  end

  specify "the error message should link directly to the #{method} field" do
    expect(subject).to have_tag('a', with: { href: "#" + identifier })
    expect(subject).to have_tag(element, with: { id: identifier })
  end

  specify 'the label should be associated with the element' do
    expect(subject).to have_tag('label', with: { for: identifier })
  end
end
