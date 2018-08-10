require_relative './application_schema'
require 'dry-validation'

class CarSchema

  # we are inheriting from common ApplicationSchema
  @@schema = Dry::Validation.Schema(ApplicationSchema) do

    # define custom methods to evaluate arguments at validation time
    configure do

      # we want to know the valid format of driver number
      def driver_name?(value)
        ! /\Adriver-#\d+\z/.match(value).nil?
      end
    end

    # filled macro expands to `required(:color) { filled? }`
    required(:color).filled

    # built-in predicates with predicate logic
    required(:year) { int? & gt?(1900) & lteq?(Date.today.year) }

    # custom predicate with optional key
    optional(:driver).filled :driver_name?

    # nested validation and high level rule
    optional(:consumption).filled do
      schema do
        required(:city).maybe :int?
        required(:highway).maybe :int?

        rule(higher_city_consumption: [:city, :highway]) do |city, highway|
          city.none? | highway.none? | city.gt?(highway)
        end
      end
    end
  end

  def self.get
    @@schema
  end
end
