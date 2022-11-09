module GOVUKDesignSystemFormBuilder
  module Elements
    class Legend < Base
      using PrefixableArray

      include Traits::Caption
      include Traits::Localisation
      include Traits::HTMLAttributes
      include Traits::HTMLClasses

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

        tag.legend(legend_content, **attributes(@html_attributes))
      end

      def options
        { class: classes }
      end

      def classes
        build_classes(
          %(fieldset__legend),
          @size_class,
          %(visually-hidden) => @hidden
        ).prefix(brand)
      end

      def legend_content
        caption_and_text = safe_join([caption_element, @text])

        return caption_and_text if @tag.blank?

        content_tag(@tag, class: heading_classes) { caption_and_text }
      end

      def retrieve_text(supplied_text)
        [supplied_text, localised_text(:legend), @attribute_name&.capitalize].find(&:presence)
      end

      def size_class(size)
        fail "invalid size '#{size}', must be xl, l, m or s" unless size.in?(%w(xl l m s))

        %(fieldset__legend--#{size})
      end

      def heading_classes
        %(#{brand}-fieldset__heading)
      end
    end
  end
end
