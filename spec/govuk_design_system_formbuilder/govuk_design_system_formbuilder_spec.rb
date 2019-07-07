describe GOVUKDesignSystemFormBuilder::FormBuilder do
  let(:helper) { TestHelper.new }
  let(:object) { Person.new(name: 'Joey') }
  let(:parsed_subject) { Nokogiri.parse(subject) }
  let(:url) { '/some/path' }
  let(:novalidate_options) { { html: { novalidate: false } } }

  before do
    module ActionView::Helpers
      def protect_against_forgery?
        false
      end
    end
  end

  context '#form_for' do
    subject do
      helper.form_for(object, url: url) do |f|
        f.text_field(:name)
      end
    end

    specify 'should output a form with novalidate set to true' do
      expect(subject).to have_tag('form', with: { novalidate: 'novalidate' })
    end

    context 'overriding novalidate and setting to false' do
      subject do
        helper.form_for(object, url: url, **novalidate_options) do |f|
          f.text_field(:name)
        end
      end

      specify 'should output a form no novalidate attribute' do
        expect(parsed_subject.at_css('form').attributes.keys).not_to include('novalidate')
      end
    end
  end

  context '#form_with' do
    subject do
      helper.form_with(model: object, url: url) do |f|
        f.text_field(:name)
      end
    end

    specify 'should output a form with novalidate set to true' do
      expect(subject).to have_tag('form', with: { novalidate: 'novalidate' })
    end

    context 'overriding novalidate and setting to false' do
      subject do
        helper.form_with(model: object, url: url, **novalidate_options) do |f|
          f.text_field(:name)
        end
      end

      specify 'should output a form no novalidate attribute' do
        expect(parsed_subject.at_css('form').attributes.keys).not_to include('novalidate')
      end
    end
  end
end
