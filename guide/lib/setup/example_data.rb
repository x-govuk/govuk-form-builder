module Setup
  module ExampleData
    def departments_data_raw
      <<~DATA
        departments = [
          OpenStruct.new(id: 1, name: 'Sales'),
          OpenStruct.new(id: 2, name: 'Marketing'),
          OpenStruct.new(id: 3, name: 'Finance')
        ]
      DATA
    end

    def departments
      eval(departments_data_raw)
    end

    def lunch_options_raw
      <<~DATA
        lunch_options = [
          OpenStruct.new(
            id: 1,
            name: 'Salad',
            description: 'Lettuce, tomato and cucumber'
          ),
          OpenStruct.new(
            id: 2,
            name: 'Jacket potato',
            description: 'With cheese and baked beans'
          )
        ]
      DATA
    end

    def lunch_options
      eval(lunch_options_raw)
    end

    def primary_colours_raw
      <<~DATA
        primary_colours = [
          OpenStruct.new(
            id: :cyan,
            name: 'Cyan',
            description: 'Greenish-blue'
          ),
          OpenStruct.new(
            id: :magenta,
            name: 'Magenta',
            description: 'Purplish-red'
          ),
          OpenStruct.new(
            id: :yellow,
            name: 'Yellow',
            description: 'Yellowy-yellow'
          )
        ]
      DATA
    end

    def primary_colours
      eval(primary_colours_raw)
    end

    def form_data
      { departments: departments, lunch_options: lunch_options, primary_colours: primary_colours }
    end
  end
end