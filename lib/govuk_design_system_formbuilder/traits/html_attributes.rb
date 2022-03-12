module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      # Attributes eases working with default and custom attributes by:
      # * deeply merging them so both the default (required) attributes are
      #   present
      class Attributes
        attr_reader :merged

        # Only try to combine and merge these attributes that contain a list of
        # values separated by a space. All other values should be merged in a
        # regular fashion (where the custom value overrides the default)
        MERGEABLE = [
          %i(class),
          %i(aria controls),
          %i(aria describedby),
          %i(aria flowto),
          %i(aria labelledby),
          %i(aria owns),
        ].freeze

        def initialize(defaults, custom)
          @merged = defaults.deeper_merge(deep_split_values(custom))
        end

      private

        def deep_split_values(hash, parent = nil)
          hash.each.with_object({}) do |(key, value), result|
            result[key] = process_value(parent, key, value)
          end
        end

        def process_value(parent, key, value)
          case value
          when String
            split_mergeable(key, value, parent)
          when Hash
            deep_split_values(value, key)
          else
            value
          end
        end

        def split_mergeable(key, value, parent = nil)
          return value.presence unless [parent, key].compact.in?(MERGEABLE)

          value.split
        end
      end

      def attributes(html_attributes = {})
        Attributes.new(options, html_attributes).merged
      end
    end
  end
end
