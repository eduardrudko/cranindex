# frozen_string_literal: true

require 'yaml'
require 'active_record'

include ActiveRecord::Tasks

root = File.expand_path '..', __FILE__
DatabaseTasks.env = 'development'
conf = File.join root, 'db/config.yml'
DatabaseTasks.database_configuration = YAML.safe_load(File.read(conf))
DatabaseTasks.db_dir = File.join root, 'db'
DatabaseTasks.migrations_paths = [File.join(root, 'db/migrations')]
DatabaseTasks.root = root

LOGGER = Logger.new($stdout)

WORKERS_POOL_SIZE = 5

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load 'active_record/railties/databases.rake'
load 'tasks/index_cran.rake'