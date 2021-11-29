# frozen_string_literal: true

class Spree::FeedbacksController < Spree::StoreController
  def index
    @items = Feedbacks::ProductsList.new(spree_current_user, current_store).do
    @variants = Spree::Variant.where(id: @items[:products].map{ |item| item['variant_id'] }.uniq)
  end

  def new
    feedback = spree_current_user.feedbacks.find_by(spree_line_item_id: params[:item])
    if feedback
      redirect_to edit_feedback_path(feedback)
    else
      order = spree_current_user.orders.joins(:line_items).find_by('spree_line_items.id = ?', params[:item])
      @variant = order.line_items.find(params[:item]).variant
      @product = @variant.product
      @feedback = spree_current_user.feedbacks.new
    end
  end

  def create
    @feedback = spree_current_user.feedbacks.find_or_create_by(
      spree_line_item_id: params[:feedback][:spree_line_item_id]
    )
    @feedback.update_attributes(feedback_params)
    redirect_to edit_feedback_path(@feedback)
  end

  def edit
    @feedback = spree_current_user.feedbacks.find(params[:id])
    @variant = @feedback.line_item.variant
    @product = @variant.product
  end

  def update
    @feedback = spree_current_user.feedbacks.find(params[:id])
    @variant = @feedback.line_item.variant
    @product = @variant.product
    @feedback.update_attributes(feedback_params)
    redirect_to edit_feedback_path(@feedback)
  end

  private

  def feedback_params
    params.require(:feedback).permit(
      :vote, :step, :completed, :other_vibe, :other_effect, :other_taste,
      effect_ids: [], taste_ids: [], vibe_ids: []
    )
  end
end
