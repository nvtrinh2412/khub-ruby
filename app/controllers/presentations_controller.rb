class PresentationsController < ApplicationController
  before_action :authorized
  # GET /presentations
  # GET /presentations.json
  DEFAULT_SLIDE = {
      id: '',
      type: 'paragraph',
      question: 'Welcome to KHUB',
      description: 'Try your best experience with us',
      answers: [],
  };

  DEFAULT_CURRENT_SLIDE = {
    id: '',
    type: 'paragraph',
    question: 'Welcome to KHUB',
    description: 'Default slide',
    answers: [],
};
  def send_current_slide
    presentation = Presentation.find(params[:presentation_id])
    current_slide = presentation.slides[params[:position].to_i]
    puts "current_slide is: #{params[:position].to_i}"
    if current_slide
      ActionCable.server.broadcast "presentation_#{presentation.id}", current_slide
      render json: current_slide
    else
      ActionCable.server.broadcast "presentation_#{presentation.id}", DEFAULT_CURRENT_SLIDE
      render json: DEFAULT_CURRENT_SLIDE
    end
  end

  def index
    @presentations = current_user.presentations
    render json: @presentations
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show
    @presentation = Presentation.find(params[:id])
    @slides = @presentation.slides
    render json: {
      presentation: @presentation,
      slides: @slides.as_json(include: :vote_options)
    }
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = current_user.presentations.create(presentation_params)

    if @presentation.save
      render json: @presentation, status: :created
    else
      render json: @presentation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    if @presentation.update(presentation_params)
      render :show, status: :ok, location: @presentation
    else
      render json: @presentation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /presentations/1
  # DELETE /presentations/1.json
  def destroy
    @presentation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = Presentation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def presentation_params
      params.permit(:name)
    end
end
