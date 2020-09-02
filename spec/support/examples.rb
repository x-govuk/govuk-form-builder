class Project
  include ActiveModel::Model
  attr_accessor(:id, :name, :description)
end

class Being
  attr_accessor(
    :name,
    :born_on,
    :gender,
    :over_18,
    :favourite_colour,
    :favourite_colour_reason,
    :projects,
    :project_responsibilities,
    :cv,
    :photo,
    :department
  )
end

class Person < Being
  include ActiveModel::Model

  validates :name, presence: { message: 'Enter a name' }
  validates :favourite_colour, presence: { message: 'Choose a favourite colour' }
  validates :projects, presence: { message: 'Select at least one project' }
  validates :cv, length: { maximum: 30 }, presence: true

  validate :born_on_must_be_in_the_past, if: -> { born_on.present? }
  validate :photo_must_be_jpeg, if: -> { photo.present? }
  validates :name, length: { minimum: 2, message: 'Name should be longer than 1' }

  def self.valid_example
    new(
      name: 'Milhouse van Houten',
      favourite_colour: 'blue',
      projects: [1, 2, 3],
      cv: 'Excellent vocabulary',
      born_on: Date.new(1980, 7, 1)
    )
  end

private

  def born_on_must_be_in_the_past
    errors.add(:born_on, 'Your date of birth must be in the past') unless born_on < Date.today
  end

  def photo_must_be_jpeg
    errors.add(:photo, 'Must be a JPEG') unless photo.end_with?('.jpeg')
  end
end

class Guest < Being
  def initialize(name:, favourite_colour:, projects:, cv:, born_on:)
    self.name             = name
    self.favourite_colour = favourite_colour
    self.projects         = projects
    self.cv               = cv
    self.born_on          = born_on
  end

  def self.example
    new(
      name: 'Minnie von Mouse',
      favourite_colour: 'red',
      projects: [4, 5, 6],
      cv: 'Basic vocabulary',
      born_on: Date.new(1974, 7, 1)
    )
  end
end

class Department
  attr_accessor :code, :name

  def initialize(code:, name:)
    self.code = code
    self.name = name
  end
end
