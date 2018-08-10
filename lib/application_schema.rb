require 'dry-validation'

# application-wide class to inherit which sets common schema options
class ApplicationSchema < Dry::Validation::Schema

  # common config for inheriting classes
  configure do |config|

    # setting common file with validation messages
    config.messages_file = File.join __dir__, 'en.yml'
  end

  # settting common validation rules for inheriting classes
  define! do

    # we want the ability to add optional tags to all the inheriting classes
    # built-in array predicate
    optional(:tags).each :str?
  end
end
