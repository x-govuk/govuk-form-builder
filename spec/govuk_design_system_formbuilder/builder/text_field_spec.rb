describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe('#govuk_text_field')   { it_behaves_like 'a regular input', 'text', 'text' }
  describe('#govuk_phone_field')  { it_behaves_like 'a regular input', 'phone', 'tel' }
  describe('#govuk_email_field')  { it_behaves_like 'a regular input', 'email', 'email' }
  describe('#govuk_url_field')    { it_behaves_like 'a regular input', 'url', 'url' }
  describe('#govuk_number_field') { it_behaves_like 'a regular input', 'number', 'number' }
end
