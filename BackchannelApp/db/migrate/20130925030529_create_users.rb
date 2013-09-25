class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name

      t.references :user_role
      t.timestamps
    end
  end
end
