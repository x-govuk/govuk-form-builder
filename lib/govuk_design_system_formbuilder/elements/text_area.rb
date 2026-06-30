module GOVUKDesignSystemFormBuilder
  module Elements
    class TextArea < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Label
      include Traits::Supplemental
      include Traits::HTMLAttributes
      include Traits::HTMLClasses
      include Traits::DataAttributesI18n

      def initialize(
        builder,
        object_name,
        attribute_name,
        hint:,
        label:,
        caption:,
        rows:,
        max_words:,
        max_chars:,
        threshold:,
        form_group:,
        description_other_text:,
        under_limit_other_text:,
        under_limit_one_text:,
        at_limit_text:,
        over_limit_other_text:,
        over_limit_one_text:,
        **kwargs,
        &block
      )
        super(builder, object_name, attribute_name, &block)

        fail ArgumentError, 'limit can be words or chars' if max_words && max_chars

        @label           = label
        @caption         = caption
        @hint            = hint
        @max_words       = max_words
        @max_chars       = max_chars
        @threshold       = threshold
        @rows            = rows
        @form_group      = form_group
        @html_attributes = kwargs

        @description_other_text = description_other_text
        @under_limit_other_text = under_limit_other_text
        @under_limit_one_text   = under_limit_one_text
        @at_limit_text          = at_limit_text
        @over_limit_other_text  = over_limit_other_text
        @over_limit_one_text    = over_limit_one_text
      end

      def html
        Containers::FormGroup.new(*bound, **@form_group.merge(limit_form_group_options), **i18n_data).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, text_area, limit_description])
        end
      end

    private

      def text_area
        @builder.text_area(@attribute_name, **attributes(@html_attributes))
      end

      def classes
        build_classes(%(textarea), %(textarea--error) => has_errors?, %(js-character-count) => limit?).prefix(brand)
      end

      def options
        {
          id: field_id(link_errors: true),
          class: classes,
          rows: @rows,
          aria: { describedby: combine_references(hint_id, error_id, limit_description_id) },
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
        return unless limit?

        tag.span(id: limit_id, class: limit_description_classes) do
          "You can enter up to #{limit_quantity} #{limit_type}"
        end
      end

      def limit_description_classes
        build_classes(%(hint), %(character-count__message)).prefix(brand)
      end

      def limit_description_id
        return unless limit?

        limit_id
      end

      def limit_form_group_options
        return {} unless limit?

        {
          class: %(#{brand}-character-count),
          data: { module: %(#{brand}-character-count) }.merge(**limit_max_options, **limit_threshold_options).compact
        }
      end

      def limit_max_options
        if @max_words
          { maxwords: @max_words }
        elsif @max_chars
          { maxlength: @max_chars }
        end
      end

      def limit_threshold_options
        { threshold: @threshold }
      end

      def i18n_data
        return {} unless limit_quantity

        attrs = case limit_type
                when 'characters'
                  [
                    I18nAttr.new('data-i18n.characters-under-limit.other', @under_limit_other_text, :default_text_area_characters_under_limit_other_text),
                    I18nAttr.new('data-i18n.characters-under-limit.one',   @under_limit_one_text,   :default_text_area_characters_under_limit_one_text),
                    I18nAttr.new('data-i18n.characters-at-limit',          @at_limit_text,          :default_text_area_characters_at_limit_text),
                    I18nAttr.new('data-i18n.characters-over-limit.other',  @over_limit_other_text,  :default_text_area_characters_over_limit_other_text),
                    I18nAttr.new('data-i18n.characters-over-limit.one',    @over_limit_one_text,    :default_text_area_characters_over_limit_one_text),
                  ]
                when 'words'
                  [
                    I18nAttr.new('data-i18n.words-under-limit.other', @under_limit_other_text, :default_text_area_words_under_limit_other_text),
                    I18nAttr.new('data-i18n.words-under-limit.one',   @under_limit_one_text,   :default_text_area_words_under_limit_one_text),
                    I18nAttr.new('data-i18n.words-at-limit',          @at_limit_text,          :default_text_area_words_at_limit_text),
                    I18nAttr.new('data-i18n.words-over-limit.other',  @over_limit_other_text,  :default_text_area_words_over_limit_other_text),
                    I18nAttr.new('data-i18n.words-over-limit.one',    @over_limit_one_text,    :default_text_area_words_over_limit_one_text),
                  ]
                end

        build_data_attr_hash(attrs)
      end
    end
  end
end
