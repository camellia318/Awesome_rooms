class RoomsController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]
  
  def index
    @q = Room.all.ransack(params[:q])
    @rooms = @q.result
  end  

  def new
    @room = current_user.created_rooms.build
  end
  
  def create
    @room = current_user.created_rooms.build(room_params)
    
    if @room.save
      redirect_to @room, notice: "登録しました"
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @reservation = current_user && current_user.reservations.find_by(room: @room)
  end
  
  def edit
    @room = current_user.created_rooms.find(params[:id])
  end
  
  def update
    @room = current_user.created_rooms.find(params[:id])
    
    if @room.update(room_params)
      redirect_to @room, notice: "更新しました"
    end
  end
  
  def destroy
    @room = current_user.created_rooms.find(params[:id])
    @room.destroy!
    redirect_to root_path, notice: "削除しました"
  end
   
  
  private
  
  def room_params
    params.require(:room).permit(
      :name, :adress, :price, :description, :image, :remove_image, :start_date, :end_date
    )
  end
  
  
    
end
