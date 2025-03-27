class RegistrationSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :email, :last_name, :created_at, :event_id

  def event_id
    object.event.id
  end
  def first_name
    object.user.first_name
  end
  def last_name
    object.user.last_name
  end
  def email
    object.user.email
  end
end
