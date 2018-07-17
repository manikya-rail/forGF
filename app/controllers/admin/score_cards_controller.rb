class Admin::ScoreCardsController < ApplicationController
  before_action :set_score_card, only: [:show, :edit, :update, :destroy]

  # GET /score_cards
  # GET /score_cards.json
  def index
    @score_cards = ScoreCard.all
  end

  # GET /score_cards/1
  # GET /score_cards/1.json
  def show
  end

  # GET /score_cards/new
  def new
    @score_card = ScoreCard.new
  end

  # GET /score_cards/1/edit
  def edit
  end

  # POST /score_cards
  # POST /score_cards.json
  def create
    @score_card = ScoreCard.new(score_card_params)

    respond_to do |format|
      if @score_card.save
        format.html { redirect_to @score_card, notice: 'Score card was successfully created.' }
        format.json { render :show, status: :created, location: @score_card }
      else
        format.html { render :new }
        format.json { render json: @score_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /score_cards/1
  # PATCH/PUT /score_cards/1.json
  def update
    respond_to do |format|
      if @score_card.update(score_card_params)
        format.html { redirect_to @score_card, notice: 'Score card was successfully updated.' }
        format.json { render :show, status: :ok, location: @score_card }
      else
        format.html { render :edit }
        format.json { render json: @score_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /score_cards/1
  # DELETE /score_cards/1.json
  def destroy
    course = @score_card.course
    @score_card.destroy
    respond_to do |format|
      format.html { redirect_to edit_admin_course_path(course), notice: 'Score card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_card
      @score_card = ScoreCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_card_params
      params.require(:score_card).permit(:tee_name, :color)
    end
end
