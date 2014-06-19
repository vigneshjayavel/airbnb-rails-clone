class ReservationsController < ApplicationController
  before_filter :reservation_from_id, :only => [:show, :edit, :update, :destroy]
	def index
		@title = "My reservations"
		@reservations = current_user.reservations
	end

	def show

	end

  def edit

  end

  def create
    result = Reservation.validate_and_create params, current_user
    flash_and_redirect result
  end

  def update
    result = Reservation.validate_and_update params, @reservation
    flash_and_redirect result
  end

  def destroy
    result = Reservation.validate_and_destroy @reservation
    flash_and_redirect result
  end
  
  private 
  def reservation_from_id
    @reservation = Reservation.find(params[:id])
  end 

end
