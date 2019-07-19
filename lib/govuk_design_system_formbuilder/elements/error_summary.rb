module GOVUKDesignSystemFormBuilder
  module Elements
    class ErrorSummary < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, title)
        @builder = builder
        @object_name = object_name
        @title = title
      end

      def html
        return nil unless object_has_errors?

        @builder.content_tag('div', class: summary_class, **error_summary_attributes) do
          @builder.safe_join(
            [
              @builder.tag.h2(@title, id: error_summary_title_id, class: summary_class('title')),
              @builder.content_tag('div', class: summary_class('body')) do
                @builder.content_tag('ul', class: ['govuk-list', summary_class('list')]) do
                  @builder.safe_join(
                    @builder.object.errors.messages.map do |attribute, messages|
                      error_list_item(attribute, messages)
                    end
                  )
                end
              end
            ]
          )
        end
      end

    private

      def error_list_item(attribute, messages)
        @builder.content_tag('li') do
          @builder.link_to(
            messages.join(', '),
            same_page_link(field_id(attribute)),
            data: {
              turbolinks: false
            }
          )
        end
      end

      def same_page_link(target)
        '#'.concat(target)
      end

      def summary_class(part = nil)
        if part
          'govuk-error-summary'.concat('__', part)
        else
          'govuk-error-summary'
        end
      end

      def field_id(attribute)
        build_id('field-error', override_attribute_name: attribute)
      end

      def error_id(attribute)
        build_id('error', override_attribute_name: attribute)
      end

      def error_summary_title_id
        'error-summary-title'
      end

      def object_has_errors?
        @builder.object.errors.any?
      end

      def error_summary_attributes
        {
          tabindex: -1,
          role: 'alert',
          data: {
            module: 'error-summary'
          },
          aria: {
            labelledby: error_summary_title_id
          }
        }
      end
    end
  end
end
