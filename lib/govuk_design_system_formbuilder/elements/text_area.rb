module GOVUKDesignSystemFormBuilder
  module Elements
    class TextArea < Base
      def initialize(builder, object_name, attribute_name, hint_text:, label:, rows:, max_words:, max_chars:, threshold:, **extra_args)
        super(builder, object_name, attribute_name)
        @label      = label
        @hint_text  = hint_text
        @extra_args = extra_args
        @max_words  = max_words
        @max_chars  = max_chars
        @threshold  = threshold
        @rows       = rows
      end

      def html
        Containers::CharacterCount.new(@builder, max_words: @max_words, max_chars: @max_chars, threshold: @threshold).html do
          Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
            @builder.safe_join(
              [
                [label_element, hint_element, error_element].map(&:html),
                @builder.text_area(
                  @attribute_name,
                  id: field_id(link_errors: true),
                  class: govuk_textarea_classes,
                  aria: { describedby: described_by(hint_element.hint_id, error_element.error_id) },
                  **@extra_args.merge(rows: @rows)
                )
              ].flatten.compact
            )
          end
        end
      end

    private

      def govuk_textarea_classes
        %w(govuk-textarea).tap do |classes|
          classes.push('govuk-textarea--error') if has_errors?
          classes.push('govuk-js-character-count') if limit?
        end
      end

      def limit?
        @max_words || @max_chars
      end
    end
  end
end
