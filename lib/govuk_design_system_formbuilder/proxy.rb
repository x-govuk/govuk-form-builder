require_relative 'base'

module GOVUKDesignSystemFormBuilder
  class Proxy < GOVUKDesignSystemFormBuilder::Base
    NullBuilder = Struct.new(:object)

    def initialize(object, object_name, attribute_name, value: nil)
      super(NullBuilder.new(object), object_name, attribute_name)

      @value = value
    end
  end
end
