module GOVUKDesignSystemFormBuilder
  module Elements
    class Submit < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, text)
        @builder = builder
        @text = text
      end

      def html
        @builder.content_tag('div', class: %w(govuk-form-group)) do
          @builder.safe_join([
            @builder.submit(@text, class: submit_button_classes),
            (yield if block_given?)
          ])
        end
      end
    private

      def submit_button_classes
        %w(govuk-button)
      end
    end
  end
end
