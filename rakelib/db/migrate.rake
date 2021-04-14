# frozen_string_literal: true

namespace :db do
  desc 'Run db migrations'
  task :migrate, %i[version] => :settings do |t, args|
    require 'sequel/core'

    Sequel.extension :migration
    Sequel.extension :schema_dumper

    Sequel.connect(Settings.db.to_h) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      include Sequel::SchemaDumper

      dump = db.dump_schema_migration(indexes: true, foreign_keys: true, same_db:true)
      path = File.expand_path('../../db', __dir__)

      File.write("#{path}/schema.rb", dump)
    end
  end
end
