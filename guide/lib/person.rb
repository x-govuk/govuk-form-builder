class Person
  include ActiveModel::Model
  attr_accessor(:name, :born_on, :gender, :over_18, :favourite_colour, :favourite_colour_reason)
end
