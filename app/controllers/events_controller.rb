class EventsController < ApplicationController
  before_action :set_chat_room
  before_action :set_event, only: [:show, :participate, :unparticipate]

  def index
    @events = @chat_room.events.order(date: :desc)
  end

  def show
    @participants = @event.users.where(id: @chat_room.user_ids)
    @non_participants = User.where(id: @chat_room.user_ids).where.not(id: @participants.pluck(:id))
  end

  def new
    @event = @chat_room.events.build
  end

  def create
    @event = @chat_room.events.build(event_params)
    if @event.save
      redirect_to chat_room_events_path(@chat_room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def participate
    @event.users << current_user unless @event.users.include?(current_user)
    redirect_to chat_room_event_path(@chat_room, @event)
  end

  def unparticipate
    @event.users.delete(current_user)
    redirect_to chat_room_event_path(@chat_room, @event)
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def set_event
    @event = @chat_room.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :garmin_url)
  end
end
