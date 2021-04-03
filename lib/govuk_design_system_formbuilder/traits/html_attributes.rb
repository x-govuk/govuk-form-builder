module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      class Parser
        # target any element where the content is a string that represents a
        # list of things separated by a space, e.g.,
        #
        # <span class="red spots">xyz</span>
        #
        # could be respresented as
        #
        # = span(class: %w(red spots)) { "xyz" }
        TARGETS = [%i(class), %i(aria describedby)].freeze

        def initialize(attributes)
          @attributes = parse(attributes)
        end

        def to_h
          @attributes
        end

      private

        def parse(attributes)
          attributes.tap do |a|
            a[:class]              = a[:class].split              if has_class_string?(a)
            a[:aria][:describedby] = a[:aria][:describedby].split if has_aria_describedby_string?(attributes)
          end
        end

        def has_class_string?(attributes)
          attributes.key?(:class) && attributes[:class].is_a?(String)
        end

        def has_aria_describedby_string?(attributes)
          attributes.dig(:aria, :describedby)&.is_a?(String)
        end
      end

      def attributes(html_attributes = {})
        options.deeper_merge(Parser.new(html_attributes).to_h)
      end
    end
  end
end
