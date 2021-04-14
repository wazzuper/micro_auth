Sequel.migration do
  change do
    create_table(:schema_info) do
      column :version, "integer", :default=>0, :null=>false
    end
    
    create_table(:schema_seeds) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users) do
      primary_key :id, :type=>:Bignum
      column :name, "text", :null=>false
      column :email, "citext", :null=>false
      column :password_digest, "text", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:email], :unique=>true
    end
    
    create_table(:user_sessions) do
      primary_key :id, :type=>:Bignum
      foreign_key :user_id, :users, :null=>false, :key=>[:id]
      column :uuid, "uuid", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:user_id]
      index [:uuid]
    end
  end
end
