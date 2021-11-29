class Spree::FeedbackEffect < ActiveRecord::Base
  belongs_to :feedback, class_name: 'Spree::Feedback', foreign_key: :spree_feedback_id
  belongs_to :effect, class_name: 'Spree::Effect', foreign_key: :spree_effect_id
end
