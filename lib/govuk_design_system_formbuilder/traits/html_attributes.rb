module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      # Attributes eases working with default and custom attributes by:
      # * deeply merging them so both the default (required) attributes are
      #   present
      # * joins the arrays into strings to maintain Rails 6.0.* compatibility
      class Attributes
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

        def to_h
          deep_join_values(@merged)
        end

      private

        def deep_split_values(hash, parent = nil)
          hash.each.with_object({}) do |(key, value), result|
            result[key] = case value
                          when Hash
                            deep_split_values(value, key)
                          when String
                            split_mergeable(key, value, parent)
                          else
                            value
                          end
          end
        end

        def split_mergeable(key, value, parent = nil)
          return value.presence unless [parent, key].compact.in?(MERGEABLE)

          value.split
        end

        def deep_join_values(hash)
          hash.each.with_object({}) do |(key, value), result|
            result[key] = case value
                          when Hash
                            deep_join_values(value)
                          when Array
                            value.uniq.join(' ').presence
                          else
                            value
                          end
          end
        end
      end

      def attributes(html_attributes = {})
        Attributes.new(options, html_attributes).to_h
      end
    end
  end
end
