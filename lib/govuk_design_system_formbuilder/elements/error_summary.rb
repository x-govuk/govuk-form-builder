module GOVUKDesignSystemFormBuilder
  module Elements
    class ErrorSummary < Base
      include Traits::Error

      def initialize(builder, object_name, title)
        @builder = builder
        @object_name = object_name
        @title = title
      end

      def html
        return nil unless object_has_errors?

        content_tag('div', class: error_summary_class, **error_summary_options) do
          safe_join([error_title, error_summary])
        end
      end

    private

      def error_title
        tag.h2(@title, id: error_summary_title_id, class: error_summary_class('title'))
      end

      def error_summary
        content_tag('div', class: error_summary_class('body')) do
          content_tag('ul', class: [%(#{brand}-list), error_summary_class('list')]) do
            safe_join(error_list)
          end
        end
      end

      def error_list
        @builder.object.errors.messages.map do |attribute, messages|
          error_list_item(attribute, messages.first)
        end
      end

      def error_list_item(attribute, message)
        tag.li(link_to(message, same_page_link(field_id(attribute)), data: { turbolinks: false }))
      end

      def same_page_link(target)
        '#'.concat(target)
      end

      def error_summary_class(part = nil)
        if part
          %(#{brand}-error-summary).concat('__', part)
        else
          %(#{brand}-error-summary)
        end
      end

      def field_id(attribute)
        build_id('field-error', attribute_name: attribute)
      end

      def error_summary_title_id
        'error-summary-title'
      end

      def object_has_errors?
        @builder.object.errors.any?
      end

      def error_summary_options
        {
          tabindex: -1,
          role: 'alert',
          data: {
            module: %(#{brand}-error-summary)
          },
          aria: {
            labelledby: error_summary_title_id
          }
        }
      end
    end
  end
end
