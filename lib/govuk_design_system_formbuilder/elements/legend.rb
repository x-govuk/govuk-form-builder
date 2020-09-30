module GOVUKDesignSystemFormBuilder
  module Elements
    class Legend < Base
      include Traits::Caption
      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, legend:, caption:, **kwargs)
        super(builder, object_name, attribute_name)

        @html_attributes = kwargs

        case legend
        when NilClass
          # do nothing
        when Proc
          @raw = capture { legend.call }
        when Hash
          defaults.merge(legend).tap do |l|
            @text    = retrieve_text(l.dig(:text))
            @hidden  = l.dig(:hidden)
            @tag     = l.dig(:tag)
            @size    = l.dig(:size)
            @caption = caption
          end
        else
          fail(ArgumentError, %(legend must be a NilClass, Proc or Hash))
        end
      end

      def html
        @raw || content
      end

    private

      def active?
        [@text, @raw].any?(&:present?)
      end

      def content
        return unless active?

        tag.legend(legend_text, class: classes, **@html_attributes)
      end

      def legend_text
        caption_and_text = safe_join([caption_element, @text])

        if @tag.present?
          content_tag(@tag, class: heading_classes) { caption_and_text }
        else
          caption_and_text
        end
      end

      def retrieve_text(supplied_text)
        [supplied_text, localised_text(:legend), @attribute_name&.capitalize].compact.first
      end

      def classes
        [%(#{brand}-fieldset__legend), size_class, visually_hidden_class].compact
      end

      def size_class
        case @size
        when 'xl' then %(#{brand}-fieldset__legend--xl)
        when 'l'  then %(#{brand}-fieldset__legend--l)
        when 'm'  then %(#{brand}-fieldset__legend--m)
        when 's'  then %(#{brand}-fieldset__legend--s)
        else
          fail "invalid size '#{@size}', must be xl, l, m or s"
        end
      end

      def visually_hidden_class
        %(#{brand}-visually-hidden) if @hidden
      end

      def heading_classes
        %(#{brand}-fieldset__heading)
      end

      def defaults
        {
          hidden: false,
          text: nil,
          tag:  config.default_legend_tag,
          size: config.default_legend_size
        }
      end
    end
  end
end
