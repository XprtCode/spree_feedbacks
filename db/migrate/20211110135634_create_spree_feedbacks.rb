class CreateSpreeFeedbacks < ActiveRecord::Migration
  def change
    create_table :spree_feedbacks do |t|
      t.references :spree_line_item, index: true, foreign_key: true
      t.references :spree_user, index: true, foreign_key: true
      t.integer :vote, default: 0
      t.integer :step, default: 1
      t.boolean :completed, default: false
      t.boolean :approved, default: false
      t.string :other_vibe
      t.string :other_effect
      t.string :other_taste
      t.text :comment

      t.timestamps null: false
    end
  end
end
