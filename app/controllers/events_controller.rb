class EventsController < ApplicationController
  before_action :set_chat_room
  before_action :set_event, only: [:show, :edit, :update, :participate, :unparticipate, :destroy]

  def index
    @events = @chat_room.events.order(date: :desc)
  end

  def show
    @participants = @event.participants
    @non_participants = User.where(id: @chat_room.user_ids).where.not(id: @participants.pluck(:id))
  end

  def new
    @event = @chat_room.events.build
  end

  def create
    @event = @chat_room.events.build(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to chat_room_event_path(@chat_room, @event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @event = Event.find(params[:id])
    @event.user = current_user  # ここでUserを設定する、もし必要な場合
    if @event.update(event_params)
      redirect_to chat_room_event_path(@chat_room, @event), notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def participate
    @event.participants << current_user unless @event.participants.include?(current_user)
    redirect_to chat_room_event_path(@chat_room, @event)
  end

  def unparticipate
    @event.participants.delete(current_user)
    redirect_to chat_room_event_path(@chat_room, @event)
  end

  def destroy
    if @event.destroy
      redirect_to chat_room_path(@chat_room), notice: 'Event was successfully deleted.'
    else
      redirect_to chat_room_event_path(@chat_room, @event), alert: 'Failed to delete the event.'
    end
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
