class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      ActionCable.server.broadcast "chatroom_channel",
                                   mod_message: message_render(@message)
      flash[:notice] = 'Message created successfully.'
    else
      flash[:alert] = 'Failed to create message.'
    end
    redirect_to chatroom_index_path
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render_to_string(
      partial: 'message',
      locals: { message: message }
    )
  end
end
