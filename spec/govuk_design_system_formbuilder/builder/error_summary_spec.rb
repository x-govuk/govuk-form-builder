describe GOVUKDesignSystemFormBuilder::FormBuilder do
  include_context 'setup builder'
  let(:method) { :govuk_error_summary }

  describe '#govuk_error_summary' do
    subject { builder.send(method) }

    context 'when the object has errors' do
      before { object.valid? }

      specify 'the error summary should be present' do
        expect(subject).to have_tag('div', with: { class: 'govuk-error-summary' })
      end

      specify 'the error summary should have a title' do
        expect(subject).to have_tag(
          'h2',
          with: { id: 'error-summary-title', class: 'govuk-error-summary__title' }
        )
      end

      specify 'the error summary should have the correct accessibility attributes' do
        expect(subject).to have_tag(
          'div',
          with: {
            class: 'govuk-error-summary',
            tabindex: '-1',
            role: 'alert',
            'data-module' => 'error-summary'
          }
        )
      end

      specify 'the error summary should contain a list with all the errors included' do
        expect(subject).to have_tag('ul', with: { class: %w(govuk-list govuk-error-summary__list) }) do
          expect(subject).to have_tag('li', count: object.errors.count)
        end
      end

      context 'error messages' do
        subject! { builder.send(method) }

        specify 'the error message list should contain the correct messages' do
          object.errors.messages.each do |_attribute, msg|
            expect(subject).to have_tag('li', text: msg.join) do
            end
          end
        end

        specify 'the error message list should contain links to relevant errors' do
          object.errors.messages.each do |attribute, _msg|
            expect(subject).to have_tag('a', with: {
              href: "#person-#{underscores_to_dashes(attribute)}-field-error",
              'data-turbolinks' => false
            })
          end
        end

        describe 'linking to elements' do
          it_behaves_like 'an error summary linking directly to a form element', :govuk_text_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_number_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_phone_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_url_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_email_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_file_field
          it_behaves_like 'an error summary linking directly to a form element', :govuk_text_area, 'textarea'

          describe 'collection select boxes' do
            let(:object) { Person.new(favourite_colour: nil) }
            let(:identifier) { 'person-favourite-colour-field-error' }
            subject do
              builder.capture do
                builder.safe_join(
                  [
                    builder.govuk_error_summary,
                    builder.govuk_collection_select(:favourite_colour, colours, :id, :name)
                  ]
                )
              end
            end

            specify "the error message should link directly to the govuk_collection_select field" do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('select', with: { id: identifier })
            end
          end

          describe 'radio button collections' do
            let(:object) { Person.new(favourite_colour: nil) }
            let(:identifier) { 'person-favourite-colour-field-error' }
            subject do
              builder.content_tag('div') do
                builder.capture do
                  builder.safe_join(
                    [
                      builder.govuk_error_summary,
                      builder.govuk_collection_radio_buttons(:favourite_colour, colours, :id, :name)
                    ]
                  )
                end
              end
            end

            specify 'the error message should link to only one radio button' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'radio', id: identifier }, count: 1)
            end

            specify 'the radio button linked to should be first' do
              expect(parsed_subject.css('input').first).to eql(parsed_subject.at_css('#' + identifier))
            end
          end

          describe 'radio button fieldsets' do
            let(:object) { Person.new(favourite_colour: nil) }
            let(:identifier) { 'person-favourite-colour-field-error' }
            subject do
              builder.content_tag('div') do
                builder.capture do
                  builder.safe_join(
                    [
                      builder.govuk_error_summary,
                      builder.govuk_radio_buttons_fieldset(:favourite_colour) do
                        builder.safe_join(
                          [
                            builder.govuk_radio_button(:favourite_colour, :red, label: { text: red_label }, link_errors: true),
                            builder.govuk_radio_button(:favourite_colour, :green, label: { text: green_label })
                          ]
                        )
                      end
                    ]
                  )
                end
              end
            end

            specify 'the error message should link to only one radio button' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'radio', id: identifier }, count: 1)
            end

            specify 'the radio button linked to should be first' do
              expect(parsed_subject.css('input').first).to eql(parsed_subject.at_css('#' + identifier))
            end
          end

          describe 'check box collections' do
            let(:object) { Person.new(projects: nil) }
            let(:identifier) { 'person-projects-field-error' }
            subject do
              builder.content_tag('div') do
                builder.capture do
                  builder.safe_join(
                    [
                      builder.govuk_error_summary,
                      builder.govuk_collection_check_boxes(:projects, projects, :id, :name)
                    ]
                  )
                end
              end
            end

            specify 'the error message should link to only one check box' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { type: 'checkbox', id: identifier }, count: 1)
            end

            specify 'the check box linked to should be first' do
              expect(parsed_subject.css("input[type='checkbox']").first).to eql(parsed_subject.at_css('#' + identifier))
            end
          end

          describe 'date fields' do
            let(:object) { Person.new(born_on: Date.today.next_year(5)) }
            let(:identifier) { 'person-born-on-field-error' }
            let(:day_field_name) { 'person[born_on(3i)]' }
            subject do
              builder.content_tag('div') do
                builder.capture do
                  builder.safe_join(
                    [
                      builder.govuk_error_summary,
                      builder.govuk_date_field(:born_on)
                    ]
                  )
                end
              end
            end

            specify 'the error message should link to only one check box' do
              expect(subject).to have_tag('a', with: { href: "#" + identifier })
              expect(subject).to have_tag('input', with: { id: identifier }, count: 1)
            end

            specify 'the targetted input should be the first field' do
              expect(parsed_subject.css("input").first).to eql(parsed_subject.at_css('#' + identifier))
            end

            specify 'the targetted input should be the day field' do
              expect(parsed_subject.at_css('#' + identifier).attribute('name').value).to eql(day_field_name)
            end
          end
        end

        def underscores_to_dashes(val)
          val.to_s.tr('_', '-')
        end
      end
    end

    context 'when the object has no errors' do
      let(:object) { Person.valid_example }
      subject { builder.send(method) }

      specify 'no error summary should be present' do
        expect(subject).to be_nil
      end
    end
  end
end
