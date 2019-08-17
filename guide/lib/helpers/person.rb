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
    :department_ids
  )
end
