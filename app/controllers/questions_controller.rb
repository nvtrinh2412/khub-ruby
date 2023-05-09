class QuestionsController < ApplicationController

  # GET /questions
  # GET /questions.json
  def index
    @questions = Presentation.find(params[:presentation_id]).questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    if @question.save
      ActionCable.server.broadcast "presentation_question_#{params[:presentation_id]}", @question.as_json
      render json: @question.as_json, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if @question.update(question_params)
      render :show, status: :ok, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:text, :presentation_id, :user_id)
    end
end
