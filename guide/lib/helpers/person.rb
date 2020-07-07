class Person
  include ActiveModel::Model

  # string fields
  attr_accessor(
    :name,
    :first_name,
    :last_name,
    :job_title,
    :postcode,
    :account_number,
    :price_per_kg
  )

  # width examples
  attr_accessor(
    :twenty,
    :ten,
    :five,
    :four,
    :three,
    :two,
    :full,
    :three_quarters,
    :one_half,
    :one_third,
    :one_quarter
  )

  # select/radio fields
  attr_accessor(
    :department_id,
    :new_department_id,
    :old_department_id,
    :lunch_id,
    :wednesday_lunch_id,
    :thursday_lunch_id,
    :old_department_description,
    :laptop,
    :contact_type
  )

  # checkbox fields
  attr_accessor(
    :lunch_ids,
    :wednesday_lunch_ids,
    :department_ids,
    :languages,
    :other_language,
    :terms_and_conditions_agreed
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
    :date_of_birth,
    :graduation_month
  )

  # labels, captions, hints and legends
  attr_accessor(
    :favourite_colour,
    :favourite_shade_of_red,
    :favourite_shade_of_orange,
    :favourite_shade_of_blue,
    :favourite_shade_of_grey,
    :favourite_primary_colour,
    :least_favourite_colour
  )

  # errors
  attr_accessor(
    :welcome_pack_reference_number,
    :welcome_pack_received_on,
    :welcome_lunch_choice
  )

  validates :welcome_pack_reference_number, presence: { message: 'Enter the reference number you received in your welcome pack' }
  validates :welcome_pack_received_on, presence: { message: 'Enter the date you received your welcome pack' }
  validates :department_id, presence: { message: %(Select the department to which you've been assigned) }
  validates :welcome_lunch_choice, presence: { message: 'Select a lunch choice for your first day' }

  # fieldset
  attr_accessor(
    :address_one,
    :address_two,
    :address_three
  )

  # file fields
  attr_accessor(
    :profile_photo
  )

  # localisation
  attr_accessor(
    :favourite_kind_of_hat,
    :role
  )
end
