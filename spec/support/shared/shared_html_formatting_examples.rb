shared_examples 'HTML formatting checks' do
  specify 'no attributes have leading or trailing spaces' do
    expect(subject.scan(%r(="(.*?)")).flatten).to all(have_no_leading_or_trailing_spaces)
  end
end
