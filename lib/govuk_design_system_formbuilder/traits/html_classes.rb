module GOVUKDesignSystemFormBuilder
  module Traits
    module HTMLClasses
      # combine all the classes in *args with any keys from **kwargs
      # where the value is true. Roughly based on the behaviour from
      # Rails' class_names, but recreated here as that returns a string
      # where we want an array.
      def build_classes(*args, **kwargs)
        # FIXME: we need to handle the arguments differently for Ruby 2.6.x because
        #        Ruby 2.7.0 brought the separation of positional and keyword
        #        arguments.
        #
        #        This can be removed once support for 2.6.x is dropped.
        #
        #        https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/
        return ruby_2_6_build_classes_fallback(*args) if RUBY_VERSION < "2.7.0"

        (args + kwargs.map { |k, v| k if v }).compact
      end

    private

      def ruby_2_6_build_classes_fallback(*args)
        [].tap do |classes|
          args.each do |arg|
            if arg.is_a?(Hash)
              arg.each { |k, v| classes.append(k) if v }
            else
              classes.append(arg)
            end
          end
        end
      end
    end
  end
end
