class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      
      t.timestamps
    end
  end
end
