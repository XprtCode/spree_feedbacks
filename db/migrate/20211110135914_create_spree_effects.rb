class CreateSpreeEffects < ActiveRecord::Migration
  def change
    create_table :spree_effects do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
