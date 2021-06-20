class ReservationsController < ApplicationController
  
  def index
    @reservations = current_user.reservations.page(params[:page]).per(1)
  end  
  
  def new
    raise ActionController::RoutingError, "ログイン状態でReservationsController#newにアクセス"
  end  
  
  def create
    room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build do |t|
      t.room = room
      t.start_date = params[:reservation][:start_date]
      t.end_date = params[:reservation][:end_date]
      t.person = params[:reservation][:person]
    end
    if @reservation.save
      redirect_to room, notice: "このルームを予約しました"
    end
  end
  
  def destroy
    reservation = current_user.reservations.find_by!(room_id: params[:room_id])
    reservation.destroy!
    redirect_to room_path(params[:room_id]), notice: "この予約をキャンセルしました"
  end  
  
  private
  
  def total_price
  end
  
  
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :person
    )
  end
  
  
end
