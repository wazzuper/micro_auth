# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:user_sessions) do
      primary_key :id, type: :Bignum
      foreign_key :user_id, :users, null: false

      Uuid :uuid, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :uuid
      index :user_id
    end
  end
end
