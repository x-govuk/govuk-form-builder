class Person
  include ActiveModel::Model
  attr_accessor(:name, :born_on, :born_at, :gender, :over_18, :favourite_colour)

  validates :name, presence: true
end
