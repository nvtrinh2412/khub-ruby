class VoteOptionsController < ApplicationController

  # GET /vote_options
  # GET /vote_options.json
  def index
    @vote_options = Slide.find(params[:slide_id]).vote_options
    render json: @vote_options
  end

  # GET /vote_options/1
  # GET /vote_options/1.json
  def show
  end

  # POST /vote_options
  # POST /vote_options.json
  def create
    @vote_option = VoteOption.new(vote_option_params)

    if @vote_option.save
      render :show, status: :created, location: @vote_option
    else
      render json: @vote_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vote_options/1
  # PATCH/PUT /vote_options/1.json
  def update
    if @vote_option.update(vote_option_params)
      render :show, status: :ok, location: @vote_option
    else
      render json: @vote_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vote_options/1
  # DELETE /vote_options/1.json
  def destroy
    @vote_option.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_option
      @vote_option = VoteOption.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_option_params
      params.require(:vote_option).permit(:text, :count)
    end
end
