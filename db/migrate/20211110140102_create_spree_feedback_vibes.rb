class CreateSpreeFeedbackVibes < ActiveRecord::Migration
  def change
    create_table :spree_feedback_vibes do |t|
      t.references :spree_feedback, index: true, foreign_key: true
      t.references :spree_vibe, index: true, foreign_key: true
      t.string :suggested

      t.timestamps null: false
    end
  end
end
