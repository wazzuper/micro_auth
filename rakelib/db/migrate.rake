# frozen_string_literal: true

namespace :db do
  desc 'Run db migrations'
  task :migrate, %i[version] => :settings do |t, args|
    require 'sequel/core'

    Sequel.extension :migration

    Sequel.connect(Settings.db.to_h) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)
    end
  end
end
