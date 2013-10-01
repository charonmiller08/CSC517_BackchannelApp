class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
    t.references :post
    t.references :parent_post
    end
  end
end
