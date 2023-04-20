class GroupsController < ApplicationController
  # before_action :set_group, only: %i[ show update destroy ]
  before_action :authorized
  # GET /groups
  # GET /groups.json
  def index
    render json: current_user.groups
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.permit(:name)
    end
end
