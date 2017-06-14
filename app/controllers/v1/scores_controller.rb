class V1::ScoresController < ApplicationController
  before_action :authenticate!
  before_action :set_score, only: [:show]

  def create
    score = Score.new(score_params)

    if score.save
      return head :ok
    else
      render json: { errors: score.errors.full_messages }, status: :failed
    end
  end

  def show
    if @score
      render :show, status: :ok
    else
      render json: { errors: 'Score not found' }, status: :failed
    end
  end

  private

  def set_score
    @score = Score.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:score, :user_id, :hole_id)
  end
end
