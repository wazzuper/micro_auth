# frozen_string_literal: true

require_relative '../../config/environment'

namespace :db do
  desc 'Add some data for the db'
  task :seed, %i[version] => :settings do |t|
    require 'sequel/core'
    require 'sequel/extensions/seed'

    Sequel.extension :seed

    Sequel.connect(Settings.db.to_h) do |db|
      seeds = File.expand_path('../../db/seeds', __dir__)
      Sequel::Seeder.apply(db, seeds)
    end
  end

  desc 'Delete data from db'
  task :truncate, %i[version] => :settings do |t|
    require 'sequel/core'

    Sequel.connect(Settings.db.to_h) do |db|
      db[:users, :user_sessions].truncate
    end
  end
end
