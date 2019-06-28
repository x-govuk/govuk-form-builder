class Person
  include ActiveModel::Model
  attr_accessor(:name, :born_on, :born_on, :gender, :over_18, :favourite_colour, :favourite_colour_reason)
  attr_accessor(:projects, :project_responsibilities)
  attr_accessor(:cv)

  validates :name, presence: true
  validates :favourite_colour, presence: true
  validates :cv, length: { maximum: 30 }
end

class Project
  include ActiveModel::Model
  attr_accessor(:id, :name, :description)
end
