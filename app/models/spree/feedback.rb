class Spree::Feedback < ActiveRecord::Base
  scope :pending, ->(){ where(completed: true, approved: false, rejected: false) }
  scope :approved, ->(){ where(approved: true) }
  scope :rejected, ->(){ where(rejected: true) }

  belongs_to :line_item, class_name: 'Spree::LineItem', foreign_key: :spree_line_item_id
  delegate :variant, to: :line_item, allow_nil: true

  belongs_to :user, class_name: 'Spree::User', foreign_key: :spree_user_id


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

  def approve!
    update_attributes(approved: true, rejected: false)
  end

  def reject!
    update_attributes(approved: false, rejected: true)
  end
end
