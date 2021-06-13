module GOVUKDesignSystemFormBuilder
  module Elements
    class ErrorSummary < Base
      include Traits::Error
      include Traits::HTMLAttributes

      def initialize(builder, object_name, title, link_base_errors_to:, order:, **kwargs)
        super(builder, object_name, nil)

        @title               = title
        @link_base_errors_to = link_base_errors_to
        @html_attributes     = kwargs
        @order               = order
      end

      def html
        return unless object_has_errors?

        tag.div(**attributes(@html_attributes)) do
          safe_join([title, summary])
        end
      end

    private

      def title
        tag.h2(@title, id: summary_title_id, class: summary_class('title'))
      end

      def summary
        tag.div(class: summary_class('body')) do
          tag.ul(class: [%(#{brand}-list), summary_class('list')]) do
            safe_join(list)
          end
        end
      end

      def list
        error_messages.map do |attribute, messages|
          list_item(attribute, messages.first)
        end
      end

      def error_messages
        messages = @builder.object.errors.messages

        if reorder_errors?
          return messages.sort_by.with_index(1) do |(attr, _val), i|
            error_order.index(attr) || (i + messages.size)
          end
        end

        @builder.object.errors.messages
      end

      def reorder_errors?
        object = @builder.object

        @order || (object.respond_to?(:error_order) && object.error_order.present?)
      end

      def error_order
        @order || @builder.object.error_order
      end

      def list_item(attribute, message)
        tag.li(link_to(message, same_page_link(field_id(attribute)), data: { turbolinks: false }))
      end

      def same_page_link(target)
        '#'.concat(target)
      end

      def classes
        Array.wrap(summary_class)
      end

      def summary_class(part = nil)
        if part
          %(#{brand}-error-summary).concat('__', part)
        else
          %(#{brand}-error-summary)
        end
      end

      def field_id(attribute)
        if attribute.eql?(:base) && @link_base_errors_to.present?
          build_id('field', attribute_name: @link_base_errors_to)
        else
          build_id('field-error', attribute_name: attribute)
        end
      end

      def summary_title_id
        'error-summary-title'
      end

      def object_has_errors?
        @builder.object.errors.any?
      end

      def options
        {
          class: classes,
          tabindex: -1,
          role: 'alert',
          data: {
            module: %(#{brand}-error-summary)
          },
          aria: {
            labelledby: summary_title_id
          }
        }
      end
    end
  end
end
