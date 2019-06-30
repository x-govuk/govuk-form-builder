class Person
  include ActiveModel::Model
  attr_accessor(:name, :born_on, :gender, :over_18, :favourite_colour, :favourite_colour_reason)
  attr_accessor(:projects, :project_responsibilities)
  attr_accessor(:cv)

  validates :name, presence: true
  validates :favourite_colour, presence: true
  validates :projects, presence: true
  validates :cv, length: { maximum: 30 }

  validate :born_on_must_be_in_the_past, if: -> { born_on.present? }

private

  def born_on_must_be_in_the_past
    errors.add(:born_on, 'Your date of birth must be in the past') unless born_on < Date.today
  end
end

class Project
  include ActiveModel::Model
  attr_accessor(:id, :name, :description)
end
