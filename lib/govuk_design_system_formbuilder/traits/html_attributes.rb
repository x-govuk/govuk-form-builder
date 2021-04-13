module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLAttributes
      # Attributes eases working with default and custom attributes by
      # * deeply merging them so both the default (required) attributes are
      #   present
      # * joins the arrays into strings to maintain Rails 6.0.3 compatibility
      class Attributes
        def initialize(defaults, custom)
          @merged = defaults.deeper_merge(deep_split_values(custom))
        end

        def to_h
          deep_join_values(@merged)
        end

      private

        def deep_split_values(hash)
          hash.each.with_object({}) do |(key, value), result|
            result[key] = case value
                          when Hash
                            deep_split_values(value)
                          when String
                            value.split
                          else
                            value
                          end
          end
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
