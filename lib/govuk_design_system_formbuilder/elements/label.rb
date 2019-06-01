module GOVUKDesignSystemFormBuilder
  module Elements
    class Label < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, **options)
        super(builder, object_name, attribute_name)

        default_options.merge(options).tap do |o|
          @text   = o&.dig(:text) || @attribute_name.capitalize
          @size   = label_size(o&.dig(:size))
          @weight = label_weight(o&.dig(:weight))
        end
      end

      def html
        return nil unless @text.present?

        @builder.tag.label(
          @text,
          class: %w(govuk-label).push(@size, @weight).compact,
          for: attribute_identifier
        )
      end

    private

      def default_options
        { weight: 'regular', size: 'regular' }
      end

      def label_size(size)
        case size
        when 'large'   then "govuk-!-font-size-48"
        when 'medium'  then "govuk-!-font-size-36"
        when 'small'   then "govuk-!-font-size-27"
        when 'regular' then nil
        else
          fail 'size must be either large, medium, small or regular'
        end
      end

      def label_weight(weight)
        case weight
        when 'bold'    then "govuk-!-font-weight-bold"
        when 'regular' then nil
        else
          fail 'weight must be bold or regular'
        end
      end
    end
  end
end
