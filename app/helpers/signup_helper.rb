module SignupHelper

  def mark_necessary_field(obj, attr)
    "*" if obj.class.validators_on(attr).map(&:class).flatten.include?(
        ActiveRecord::Validations::PresenceValidator)
  end
end
