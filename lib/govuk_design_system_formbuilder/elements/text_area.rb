module GOVUKDesignSystemFormBuilder
  module Elements
    class TextArea < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental

      def initialize(builder, object_name, attribute_name, hint_text:, label:, caption:, rows:, max_words:, max_chars:, threshold:, form_group_classes:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label              = label
        @caption            = caption
        @hint_text          = hint_text
        @max_words          = max_words
        @max_chars          = max_chars
        @threshold          = threshold
        @rows               = rows
        @form_group_classes = form_group_classes
        @html_attributes    = kwargs
      end

      def html
        Containers::CharacterCount.new(@builder, **character_count_options).html do
          Containers::FormGroup.new(@builder, @object_name, @attribute_name, classes: @form_group_classes).html do
            safe_join([label_element, supplemental_content, hint_element, error_element, text_area, limit_description])
          end
        end
      end

    private

      def character_count_options
        { max_words: @max_words, max_chars: @max_chars, threshold: @threshold }
      end

      def text_area
        @builder.text_area(@attribute_name, **options, **@html_attributes)
      end

      def classes
        %w(textarea).prefix(brand).tap do |classes|
          classes.push(%(#{brand}-textarea--error))    if has_errors?
          classes.push(%(#{brand}-js-character-count)) if limit?
        end
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          rows: @rows,
          aria: { describedby: described_by(hint_id, error_id, supplemental_id, limit_description_id) },
        }
      end

      # Provides an id for use by the textual description of character and word limits.
      #
      # @note In order for the GOV.UK Frontend JavaScript to pick up this associated field
      #   it has to have the same id as the text area with the additional suffix of '-info'
      def limit_id
        [field_id(link_errors: true), 'info'].join('-')
      end

      def limit?
        limit_quantity.present?
      end

      def limit_quantity
        @max_words || @max_chars
      end

      def limit_type
        @max_words.present? ? 'words' : 'characters'
      end

      def limit_description
        return nil unless limit?

        tag.span(id: limit_id, class: limit_description_classes, aria: { live: 'polite' }) do
          "You can enter up to #{limit_quantity} #{limit_type}"
        end
      end

      def limit_description_classes
        %w(hint character-count__message).prefix(brand)
      end

      def limit_description_id
        return nil unless limit?

        limit_id
      end
    end
  end
end
