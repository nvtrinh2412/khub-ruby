class PresentationChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "presentation_#{params[:presentation_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
