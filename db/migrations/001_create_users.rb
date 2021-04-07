# frozen_string_literal: true

Sequel.migration do
  change do
    run 'CREATE EXTENSION IF NOT EXISTS citext'

    create_table(:users) do
      primary_key :id, type: :Bignum

      String :name, null: false
      Citext :email, null: false
      String :password_digest, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :email, unique: true
    end
  end
end
