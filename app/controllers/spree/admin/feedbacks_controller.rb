# frozen_string_literal: true

class Spree::Admin::FeedbacksController < Spree::Admin::BaseController
  def index
    @feedbacks = Spree::Feedback.send(params[:state]).page(params[:page]).per(10)
  end

  def approve
    @feedback = Spree::Feedback.find(params[:id])
    @feedback.approve!
    flash[:success] = 'You have approved a feedback'
    redirect_to admin_feedbacks_path(state: :pending)
  end

  def reject
    @feedback = Spree::Feedback.find(params[:id])
    @feedback.reject!
    flash[:success] = 'You have rejected a feedback'
    redirect_to admin_feedbacks_path(state: :pending)
  end

  def show
    @feedback = Spree::Feedback.find(params[:id])
  end
end
