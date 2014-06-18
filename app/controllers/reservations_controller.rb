class ReservationsController < ApplicationController
	def index
		@title = "My reservations"
		@reservations = current_user.reservations
	end

	def show
    reservation_from_id
	end

  def edit
    reservation_from_id
  end

  def create
    result = Reservation.validate_and_create params, current_user
    flash_and_redirect result
  end

  def update
    reservation_from_id
    result = Reservation.validate_and_update params, @reservation
    flash_and_redirect result
  end

  def destroy
    reservation_from_id
    result = Reservation.validate_and_destroy @reservation
    flash_and_redirect result
  end
  
  private 
  def reservation_from_id
    @reservation = Reservation.find(params[:id])
  end 

end
