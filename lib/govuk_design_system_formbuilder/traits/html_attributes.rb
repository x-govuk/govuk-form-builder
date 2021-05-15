module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      # Attributes eases working with default and custom attributes by:
      # * deeply merging them so both the default (required) attributes are
      #   present
      # * joins the arrays into strings to maintain Rails 6.0.3 compatibility
      class Attributes
        # Rather than attempt to combine these attributes, just overwrite the
        # form internally-generated values with those that are passed in. This
        # prevents the merge/unique value logic from affecting the content
        # (i.e. by remvoving duplicated words).
        UNMERGEABLE = [%i(id), %i(value), %i(title), %i(alt), %i(href), %i(aria label)].freeze

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
          return value if [parent, key].compact.in?(UNMERGEABLE)

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
