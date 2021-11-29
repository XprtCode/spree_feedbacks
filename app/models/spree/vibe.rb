class Spree::Vibe < ActiveRecord::Base
  has_many :feedback_vibes, class_name: 'Spree::FeedbackVibe', foreign_key: :spree_feedback_id
  has_many :feedbacks, through: :feedback_vibes, class_name: 'Spree::Feedback', foreign_key: :spree_feedback_id

  validates_presence_of :name, message: "can't be blank"
end
