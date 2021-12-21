module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLClasses
      # combine all the classes in *args with any keys from **kwargs
      # where the value is true. Roughly based on the behaviour from
      # Rails' class_names, but recreated here as that returns a string
      # where we want an array.
      def build_classes(*args, **kwargs)
        (args + kwargs.map { |k, v| k if v }).compact
      end
    end
  end
end
