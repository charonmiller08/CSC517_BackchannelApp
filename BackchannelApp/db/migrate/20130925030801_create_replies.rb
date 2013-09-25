class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|

      t.references :post
      t.timestamps
    end
  end
end
