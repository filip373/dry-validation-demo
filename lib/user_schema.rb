require 'dry-validation'

class UserSchema

  # using Validation.Params class to perform form validation
  @@schema = Dry::Validation.Params do

    # score param coerced to integer
    required(:score).filled :int?

    # subscribed param coerced to boolean
    required(:subscribed).filled :bool?
  end

  def self.get
    @@schema
  end
end
