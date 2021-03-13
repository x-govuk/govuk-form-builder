module GOVUKDesignSystemFormBuilder
  module Elements
    class Legend < Base
      include Traits::Caption
      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, text: nil, size: config.default_legend_size, hidden: false, tag: config.default_legend_tag, caption: nil, content: nil, **kwargs)
        super(builder, object_name, attribute_name)

        if content
          @content = capture { content.call }
        else
          @text            = retrieve_text(text)
          @tag             = tag
          @size_class      = size_class(size)
          @tag             = tag
          @caption         = caption
          @hidden          = hidden
          @html_attributes = kwargs
        end
      end

      def html
        @content || legend
      end

    private

      def active?
        [@text, @content].any?(&:present?)
      end

      def legend
        return unless active?

        tag.legend(legend_content, class: classes, **@html_attributes)
      end

      def legend_content
        caption_and_text = safe_join([caption_element, @text])

        return caption_and_text if @tag.blank?

        content_tag(@tag, class: heading_classes) { caption_and_text }
      end

      def retrieve_text(supplied_text)
        [supplied_text, localised_text(:legend), @attribute_name&.capitalize].compact.first
      end

      def classes
        [%(#{brand}-fieldset__legend), @size_class, visually_hidden_class].compact
      end

      def size_class(size)
        if size.in?(%w(xl l m s))
          %(#{brand}-fieldset__legend--#{size})
        else
          fail "invalid size '#{size}', must be xl, l, m or s"
        end
      end

      def visually_hidden_class
        %(#{brand}-visually-hidden) if @hidden
      end

      def heading_classes
        %(#{brand}-fieldset__heading)
      end
    end
  end
end
