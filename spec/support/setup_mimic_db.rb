dbconf = YAML::load(File.open('spec/support/database.yml'))
ActiveRecord::Base.establish_connection(dbconf)

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
ActiveRecord::Base.logger = Logger.new($STDOUT)
ActiveRecord::Migrator.up('spec/support/migrations')
