module GOVUKDesignSystemFormBuilder
  module Elements
    class TextArea < Base
      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental

      def initialize(builder, object_name, attribute_name, hint_text:, label:, rows:, max_words:, max_chars:, threshold:, **extra_args, &block)
        super(builder, object_name, attribute_name, &block)

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
            safe_join(
              [
                [
                  label_element,
                  supplemental_content,
                  hint_element,
                  error_element
                ].map(&:html),
                @builder.text_area(
                  @attribute_name,
                  id: field_id(link_errors: true),
                  class: govuk_textarea_classes,
                  aria: {
                    describedby: described_by(hint_id, error_id, supplemental_id, limit_description_id)
                  },
                  **@extra_args.merge(rows: @rows)
                ),
                limit_description
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

      # Provides an id for use by the textual description of character and word limits.
      #
      # @note In order for the GOV.UK Frontend JavaScript to pick up this associated field
      #   it has to have the same id as the text area with the additional suffix of '-info'
      def limit_id
        [field_id(link_errors: true), 'info'].join('-')
      end

      def limit?
        @max_words || @max_chars
      end

      def limit_description
        return nil unless limit?

        content_tag('span', id: limit_id, class: %w(govuk-hint govuk-character-count__message), aria: { live: 'polite' }) do
          "You can enter up to #{limit_quantity} #{limit_type}"
        end
      end

      def limit_quantity
        @max_words || @max_chars
      end

      def limit_type
        @max_words.present? ? 'words' : 'characters'
      end

      def limit_description_id
        return nil unless limit?

        limit_id
      end
    end
  end
end
