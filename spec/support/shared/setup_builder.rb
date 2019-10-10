shared_context 'setup builder' do
  let(:action_view_context) { ActionView::LookupContext.new(nil) }
  let(:helper) { ActionView::Base.new(action_view_context) }
  let(:object) { Person.new(name: 'Joey') }
  let(:object_name) { :person }
  let(:builder) { described_class.new(object_name, object, helper, {}) }
  let(:parsed_subject) { Nokogiri::HTML::DocumentFragment.parse(subject) }
end
