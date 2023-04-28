class ChatsController < ApplicationController
  before_action :authorized , except: [:index, :create]
  def index
    @chats = Presentation.find(params[:presentation_id]).chats
  end

  # GET /chats/1
  # GET /chats/1.json

  # POST /chats
  # POST /chats.json
  def create
    @presentation = Presentation.find(params[:presentation_id])
    @chat = @presentation.chats.create(chat_params)
    if @chat.save
      ActionCable.server.broadcast "presentation_chat_#{params[:presentation_id]}", @chat.as_json
      render json: @chat.as_json, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private
    def chat_params
      params.require(:chats).permit(:text, :presentation_id, :sender_id)
    end


end
