class PresentationQuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "presentation_question_#{params[:presentation_id]}"
  end

  def unsubscribed
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end
end
