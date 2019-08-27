class Person
  include ActiveModel::Model

  # string fields
  attr_accessor(
    :name,
    :first_name,
    :last_name,
    :job_title,
    :postcode
  )

  # select/radio fields
  attr_accessor(
    :department_id,
    :new_department_id,
    :old_department_id,
    :lunch_id,
    :old_department_description
  )

  # checkbox fields
  attr_accessor(
    :lunch_ids,
    :department_ids,
    :languages,
    :other_language
  )

  # textarea fields
  attr_accessor(
    :responsibilities,
    :job_description,
    :cv,
    :education_history
  )

  # date fields
  attr_accessor(
    :date_of_birth
  )

  # labels, hints and legends
  attr_accessor(
    :favourite_colour,
    :favourite_shade_of_red,
    :favourite_shade_of_blue,
    :favourite_primary_colour
  )

  # errors
  attr_accessor(
    :reference_number
  )

  validates :reference_number, presence: { message: 'Enter the reference number you received in your welcome pack' }
end
