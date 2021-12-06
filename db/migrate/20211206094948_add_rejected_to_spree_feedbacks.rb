class AddRejectedToSpreeFeedbacks < ActiveRecord::Migration
  def change
    add_column :spree_feedbacks, :rejected, :boolean, default: false
  end
end
