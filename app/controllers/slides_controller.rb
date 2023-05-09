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
    @slides = @presentation.slides.create(create_slides_list_params)

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

  def destroy_list
    @slides = Slide.where(id: delete_slides_list_params)
    @slides.destroy_all
  end

  def update_list
    @slides = Slide.update(update_slides_list_params.map { |slide_params| slide_params[:id] }, update_slides_list_params)
    if @slides.all?(&:valid?)
      render json: @slides
    else
      render json: @slides.errors, status: :unprocessable_entity, message: 'Error while updating slides'
    end
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

    def create_slides_list_params
      params.require(:slides).map do |slide_params|
        slide_params.permit( :sort, :question, :description)
      end
    end

    def update_slides_list_params
      params.require(:slides).map do |slide_params|
        slide_params.permit( :id, :sort, :question, :description)
      end
    end

    def delete_slides_list_params
      params.require(:slides)
    end
end
