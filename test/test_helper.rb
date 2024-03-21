ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    # Creamos este método para estar logeados antes de hacer los tests y que no se rompan
    # por la proteccion que tenemos para usuarios no logeados
    def login
      post sessions_path, params: { login: users(:sara).username, password: 'testme' } # Session no es un modelo entonces no pasamos hash de modelo sino solo hash
    end
  end
end
