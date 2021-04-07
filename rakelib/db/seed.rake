# frozen_string_literal: true

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
end
