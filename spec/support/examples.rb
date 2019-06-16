class Person
  include ActiveModel::Model
  attr_accessor(:name, :born_on, :born_at, :gender, :over_18, :favourite_colour, :favourite_colour_reason)

  attr_accessor(:projects)

  validates :name, presence: true
end

class Project
  include ActiveModel::Model
  attr_accessor(:id, :name, :description)
end
