class PresentationSlideChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "presentation_slides_#{params[:presentation_id]}"
  end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
