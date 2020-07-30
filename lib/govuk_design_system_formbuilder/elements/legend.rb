module GOVUKDesignSystemFormBuilder
  module Elements
    class Legend < Base
      include Traits::Caption
      include Traits::Localisation

      def initialize(builder, object_name, attribute_name, legend:, caption:)
        super(builder, object_name, attribute_name)

        case legend
        when Proc
          @raw = legend.call
        when Hash
          defaults.merge(legend).tap do |l|
            @text    = text(l.dig(:text))
            @hidden  = l.dig(:hidden)
            @tag     = l.dig(:tag)
            @size    = l.dig(:size)
            @caption = caption
          end
        else
          fail(ArgumentError, %(legend must be a Proc or Hash))
        end
      end

      def html
        @raw || content
      end

    private

      def content
        if @text.present?
          tag.legend(class: classes) do
            content_tag(@tag, class: heading_classes) do
              safe_join([caption_element, @text])
            end
          end
        end
      end

      def text(supplied_text)
        supplied_text || localised_text(:legend)
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
