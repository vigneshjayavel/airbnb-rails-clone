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
    result = Listing.validate_and_create params, current_user
    set_flash_notice result[:message]
    redirect_to result[:path]
  end

  def update
    reservation_from_id
    if @reservation.update_attributes(params[:reservation])
       set_flash_notice "Reservation was successfully updated."
       redirect_to(@reservation)
    else
      render :action => "edit"
    end
    
  end

  def destroy
    reservation_from_id
    listing = Listing.find(@reservation.listing_id)
    if Date.today < @reservation.check_in + listing.notice_period 
      @reservation.destroy
      redirect_to(reservations_path)
    else 
      set_flash_notice "You cannot cancel the reservation. Minimum notice period is #{listing.notice_period} days"
      redirect_to(@reservation)
    end
  end
  
  private 
  def reservation_from_id
    @reservation = Reservation.find(params[:id])
  end 

  def set_flash_notice(message)
    flash[:notice] = message
  end

end
