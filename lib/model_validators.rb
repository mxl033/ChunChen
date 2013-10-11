class EmailFormatValidator < ActiveModel::EachValidator

  def validate_each(obj, attr, value)
    unless /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i =~ value
      obj.errors[attr] << (options[:message] || "has invalid format")
    end
  end
end

class PasswordFormatValidator < ActiveModel::EachValidator

  def validate_each(obj, attr, value)
    unless /\A[a-zA-Z0-9]+\z/ =~ value
      obj.errors[attr] << (options[:message] ||
                           "only allows alphabet letters and numbers")
    end
  end
end

