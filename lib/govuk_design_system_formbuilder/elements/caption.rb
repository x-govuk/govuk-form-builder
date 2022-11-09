module GOVUKDesignSystemFormBuilder
  module Elements
    class Caption < Base
      include Traits::Localisation
      include Traits::HTMLAttributes
      include Traits::HTMLClasses

      def initialize(builder, object_name, attribute_name, text: nil, size: config.default_caption_size, **kwargs)
        super(builder, object_name, attribute_name)

        @text            = text(text)
        @size_class      = size_class(size)
        @html_attributes = kwargs
      end

      def html
        return unless active?

        tag.span(@text, **attributes(@html_attributes))
      end

    private

      def options
        { class: @size_class }
      end

      def active?
        @text.present?
      end

      def text(override)
        override || localised_text(:caption)
      end

      def size_class(size)
        fail ArgumentError, "invalid size '#{size}', must be xl, l or m" unless size.in?(%w(xl l m))

        %(#{brand}-caption-#{size})
      end
    end
  end
end
