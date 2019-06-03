describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'

  describe('#govuk_text_field')   { it_behaves_like 'a regular input', 'text' }
  describe('#govuk_tel_field')    { it_behaves_like 'a regular input', 'tel' }
  describe('#govuk_email_field')  { it_behaves_like 'a regular input', 'email' }
  describe('#govuk_url_field')    { it_behaves_like 'a regular input', 'url' }
  describe('#govuk_number_field') { it_behaves_like 'a regular input', 'number' }
end
