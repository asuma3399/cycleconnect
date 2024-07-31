class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :destroy]

  def index
    @chat_rooms = current_user.chat_rooms
  end

  def new
    @chat_room = ChatRoom.new
    @users = User.where.not(id: current_user.id) # ログインユーザーを除外
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      @chat_room.users << current_user
      redirect_to chat_rooms_path
    else
      @users = User.where.not(id: current_user.id) # エラー時に再度ユーザーリストを取得
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @messages = @chat_room.messages
  end

  def destroy
    @chat_room.chat_room_users.destroy_all
    @chat_room.destroy
    redirect_to chat_rooms_path
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  def chat_room_params
    params.require(:chat_room).permit(:name, user_ids: [])
  end

end
