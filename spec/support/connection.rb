require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file(File.expand_path('../../db/database.yml',__FILE__))
ActiveRecord::Base.establish_connection((ENV['DB'] || 'sqlite3').to_sym)
load(File.expand_path('../../db/schema.rb',__FILE__))
