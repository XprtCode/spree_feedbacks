class Spree::FeedbackVibe < ActiveRecord::Base
  belongs_to :feedback, class_name: 'Spree::Feedback', foreign_key: :spree_feedback_id
  belongs_to :vibe, class_name: 'Spree::Vibe', foreign_key: :spree_vibe_id
end
