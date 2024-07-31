class MessagesController < ApplicationController
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user
    if @message.save
      redirect_to chat_room_path(@chat_room)
    else
      @messages = @chat_room.messages
      render "chat_rooms/show", status: :unprocessable_entity
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
