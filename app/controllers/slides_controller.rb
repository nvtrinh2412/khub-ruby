class SlidesController < ApplicationController
  before_action :authorized

  # GET /slides
  # GET /slides.json

  def current
    return render json: { error: 'No current slide' }
  end

  def index
    @slides = Presentation.find(params[:presentation_id]).slides
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
    @slide = Slide.find(params[:id])
    render json: @slide
  end

  # POST /slides
  # POST /slides.json
  def create
    @presentation = Presentation.find(params[:presentation_id])
    @slides = @presentation.slides.create(slides_list_params)

    if @slides.all?(&:persisted?) # &:persisted? => short hand
      render json: @slides, status: :created
    else
      render json: @slides.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slides/1
  # PATCH/PUT /slides/1.json
  def update
    if @slide.update(slide_params)
      render :show, status: :ok, location: @slide
    else
      render json: @slide.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
      @slide = Slide.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slide_params
      params.require(:slide).permit(:question, :description, :sort )
    end

    def slides_list_params
      params.require(:slides).map do |slide_params|
        slide_params.permit(:sort, :question, :description)
      end
    end
end
