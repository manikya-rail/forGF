class V1::ReviewsController < ApplicationController
  before_action :authenticate!
  before_action :set_review, only: [:show]

  def show
    if @review
      render :show, status: :ok
    else
      render json: {errors: "Review not found"}, status: :failed
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end
end
