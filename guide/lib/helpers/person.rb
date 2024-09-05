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
    :price_per_kg,
    :national_insurance_number_with_spacing,
    :national_insurance_number_without_spacing,
  )

  # password examples
  attr_accessor(
    :password_1,
    :password_2,
    :password_3
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
    :two_thirds,
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
    :movie_genres,
    :other_movie_genres,
    :terms_and_conditions_agreed,
    :countries
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
    :favourite_shade_of_purple,
    :favourite_shade_of_grey,
    :favourite_primary_colour,
    :least_favourite_colour,
    :crayons_or_felt_tips
  )

  # errors
  attr_accessor(
    :welcome_pack_reference_number,
    :welcome_pack_received_on,
    :welcome_lunch_choice,
    :email_address,
    :telephone_number
  )

  validates :name, presence: { message: %(Enter a name) }, on: :presenters
  validates :date_of_birth, presence: { message: %(Enter a valid date of birth) }, on: :presenters

  validates :welcome_pack_reference_number, presence: { message: 'Enter the reference number you received in your welcome pack' }, on: :fields
  validates :welcome_pack_received_on, presence: { message: 'Enter the date you received your welcome pack' }, on: :fields
  validates :department_id, presence: { message: %(Select the department to which you've been assigned) }, on: :fields
  validates :welcome_lunch_choice, presence: { message: 'Select a lunch choice for your first day' }, on: :fields

  validate :telephone_number_or_email_address_exists, on: :base_errors

  def telephone_number_or_email_address_exists
    if telephone_number.blank? && email_address.blank?
      errors.add(:base, "Enter a telephone number or email address")
    end
  end

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
