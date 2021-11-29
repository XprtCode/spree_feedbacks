class Spree::FeedbackTaste < ActiveRecord::Base
  belongs_to :feedback, class_name: 'Spree::Feedback', foreign_key: :spree_feedback_id
  belongs_to :taste, class_name: 'Spree::Taste', foreign_key: :spree_taste_id
end
