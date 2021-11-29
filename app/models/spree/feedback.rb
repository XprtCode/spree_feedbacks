class Spree::Feedback < ActiveRecord::Base
  belongs_to :line_item, class_name: 'Spree::LineItem', foreign_key: :spree_line_item_id
  belongs_to :spree_user
  delegate :variant, to: :spree_line_item, allow_nil: true

  has_many :feedback_effects, class_name: 'Spree::FeedbackEffect', foreign_key: :spree_feedback_id, dependent: :destroy
  has_many :effects, through: :feedback_effects, foreign_key: :spree_effect_id
  accepts_nested_attributes_for :feedback_effects

  has_many :feedback_tastes, class_name: 'Spree::FeedbackTaste', foreign_key: :spree_feedback_id, dependent: :destroy
  has_many :tastes, through: :feedback_tastes, foreign_key: :spree_taste_id
  accepts_nested_attributes_for :feedback_tastes

  has_many :feedback_vibes, class_name: 'Spree::FeedbackVibe', foreign_key: :spree_feedback_id, dependent: :destroy
  has_many :vibes, through: :feedback_vibes, foreign_key: :spree_vibe_id
  accepts_nested_attributes_for :feedback_vibes

  def next_step
    return 5 if self.step == 4

    self.step += 1
  end
end
