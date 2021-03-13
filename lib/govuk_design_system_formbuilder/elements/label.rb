module GOVUKDesignSystemFormBuilder
  module Elements
    class Label < Base
      using PrefixableArray

      include Traits::Caption
      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, text: nil, value: nil, size: nil, hidden: false, radio: false, checkbox: false, tag: nil, link_errors: true, content: nil, caption: nil, **kwargs)
        super(builder, object_name, attribute_name)

        @value           = value # used by field_id
        @tag             = tag
        @radio           = radio
        @checkbox        = checkbox
        @link_errors     = link_errors
        @html_attributes = kwargs

        # content is passed in directly via a proc and overrides
        # the other display options
        if content
          @content = capture { content.call }
        else
          @text       = retrieve_text(text, hidden)
          @size_class = size_class(size)
          @caption    = caption
        end
      end

      def html
        return unless active?

        if @tag.present?
          content_tag(@tag, class: %(#{brand}-label-wrapper)) { label }
        else
          label
        end
      end

      def active?
        [@content, @text].any?(&:present?)
      end

    private

      def label
        @builder.label(@attribute_name, **options, **@html_attributes) do
          @content || safe_join([caption, @text])
        end
      end

      def retrieve_text(option_text, hidden)
        text = [option_text, localised_text(:label), @attribute_name.capitalize].compact.first

        if hidden
          tag.span(text, class: %(#{brand}-visually-hidden))
        else
          text
        end
      end

      def options
        {
          value: @value,
          for: field_id(link_errors: @link_errors),
          class: %w(label).prefix(brand).push(@size_class, @weight_class, radio_class, checkbox_class).compact
        }
      end

      def caption
        caption_element.html unless [@radio, @checkbox].any?
      end

      def radio_class
        return unless @radio

        %(#{brand}-radios__label)
      end

      def checkbox_class
        return unless @checkbox

        %(#{brand}-checkboxes__label)
      end

      def size_class(size)
        case size
        when 'xl' then %(#{brand}-label--xl)
        when 'l'  then %(#{brand}-label--l)
        when 'm'  then %(#{brand}-label--m)
        when 's'  then %(#{brand}-label--s)
        when nil  then nil
        else
          fail "invalid size '#{size}', must be xl, l, m, s or nil"
        end
      end
    end
  end
end
