module GOVUKDesignSystemFormBuilder
  module Elements
    class TextArea < Base
      def initialize(builder, object_name, attribute_name, hint:, label:, rows:, max_words:, max_chars:, **extra_args)
        super(builder, object_name, attribute_name)
        @label      = label
        @hint       = hint
        @extra_args = extra_args
        @max_words  = max_words
        @max_chars  = max_chars
        @rows       = rows
      end

      def html
        hint_element  = Elements::Hint.new(@builder, @object_name, @attribute_name, @hint)
        label_element = Elements::Label.new(@builder, @object_name, @attribute_name, @label)
        error_element = Elements::ErrorMessage.new(@builder, @object_name, @attribute_name)

        Containers::CharacterCount.new(@builder, max_words: @max_words, max_chars: @max_chars).html do
          Containers::FormGroup.new(@builder, @object_name, @attribute_name).html do
            @builder.safe_join(
              [
                label_element.html,
                hint_element.html,
                error_element.html,
                @builder.text_area(
                  @attribute_name,
                  class: govuk_textarea_classes,
                  **@extra_args.merge(rows: @rows)
                ),
                character_count_info
              ]
            )
          end
        end
      end

    private

      def govuk_textarea_classes
        %w(govuk-textarea).tap do |classes|
          classes.push('govuk-textarea--error') if has_errors?
          classes.push('js-character-count') if limit?
        end
      end

      def character_count_info
        return nil unless limit?

        @builder.tag.span(
          "You can enter up to #{character_count_description}",
          class: %w(govuk-hint govuk-character-count__message),
          aria: { live: 'polite' }
        )
      end

      def character_count_description
        if @max_words
          "#{@max_words} words"
        elsif @max_chars
          "#{@max_chars} characters"
        end
      end

      def limit?
        @max_words || @max_chars
      end
    end
  end
end
