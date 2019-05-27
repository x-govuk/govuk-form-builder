module GOVUKDesignSystemFormBuilder
  module Helpers
  private
    def attribute_identifier(attribute_name)
      "%<object_name>s[%<attribute_name>s]" % {
        object_name: object_name,
        attribute_name: attribute_name
      }
    end

    def hint_id(attribute_name)
      [object_name, attribute_name, 'hint'].join('-')
    end
  end
end
