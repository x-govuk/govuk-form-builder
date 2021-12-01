module GOVUKDesignSystemFormBuilder
  module Traits
    module Error
      def error_id
        return unless has_errors?

        build_id('error')
      end

    private

      def error_element
        @error_element ||= Elements::ErrorMessage.new(*bound)
      end

      def set_message_safety(message)
        config.trust_error_messages ? message.html_safe : message
      end
    end
  end
end
