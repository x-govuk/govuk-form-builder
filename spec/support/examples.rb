class Project
  include ActiveModel::Model
  attr_accessor(:id, :name, :description)
end

class Stationery
  include ActiveModel::Model
  attr_accessor(:id, :name, :description)
end

class Being
  attr_accessor(
    :name,
    :born_on,
    :gender,
    :over18,
    :favourite_colour,
    :favourite_colour_reason,
    :projects,
    :project_responsibilities,
    :cv,
    :photo,
    :department,
    :stationery,
    :stationery_choice
  )

  def initialize(_args = nil)
    # do nothing
  end
end

class Person < Being
  include ActiveModel::Model

  validates :name,
            presence: { message: 'Enter a name' },
            length: { minimum: 2, message: 'Name should be longer than 1' }
  validates :favourite_colour, presence: { message: 'Choose a favourite colour' }
  validates :projects, presence: { message: 'Select at least one project' }
  validates :cv, length: { maximum: 30 }, presence: true

  validate :born_on_must_be_in_the_past, if: -> { born_on.present? }
  validate :photo_must_be_jpeg, if: -> { photo.present? }

  def self.valid_example
    new(
      name: 'Milhouse van Houten',
      favourite_colour: 'blue',
      projects: [1, 2, 3],
      cv: 'Excellent vocabulary',
      born_on: Date.new(1980, 7, 1)
    )
  end

  def self.with_errors_on_base(msg = "This person is always invalid")
    new.tap do |person|
      if rails_version_later_than_6_1_0?
        person.errors.add(:base, msg)
      else
        # :nocov:
        person.errors[:base].push(msg)
        # :nocov:
      end
    end
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

    super
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

WrongDate = Struct.new(:d, :m, :y)

class OrderedErrors
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :a, :string
  attribute :b, :string
  attribute :c, :string
  attribute :d, :string
  attribute :e, :string

  validates :a, presence: true, length: { minimum: 3 }
  validates :b, presence: true, length: { minimum: 3 }
  validates :c, presence: true, length: { minimum: 3 }
  validates :d, presence: true, length: { minimum: 3 }
  validates :e, presence: true, length: { minimum: 3 }
end

class OrderedErrorsWithCustomOrder < OrderedErrors
  def error_order
    %i(e d c b a)
  end
end

class OrderedErrorsWithExtraAttributes < OrderedErrors
  attribute :g, :string
  attribute :h, :string
  attribute :i, :string

  validates :i, presence: true, length: { minimum: 3 }
  validates :h, presence: true, length: { minimum: 3 }
  validates :g, presence: true, length: { minimum: 3 }
end
