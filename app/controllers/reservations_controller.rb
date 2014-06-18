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
    @reservation = current_user.reservations.new(params[:reservation])
    listing = Listing.find(params[:reservation][:listing_id])
    if Date.today > listing.availability_from && Date.today > listing.availability_to
      message = "The listing's availability has expired"
      path = reserve_listing_url params[:reservation][:listing_id]
    elsif listing.availability_from > @reservation.check_in || listing.availability_to < @reservation.check_out
      message = "You can reserve this listing only for the period #{listing.availability_from} - #{listing.availability_to}"
      path = reserve_listing_url params[:reservation][:listing_id]
    else
      if @reservation.save
        message = "Reservation was successfully created."
        path = @reservation  
      else
        message = @reservation.errors.full_messages.to_sentence
        path = reserve_listing_url params[:reservation][:listing_id]
      end
    end
    set_flash_notice message
    redirect_to path

  end

  def update
    reservation_from_id
    if @reservation.update_attributes(params[:reservation])
       set_flash_notice 'Reservation was successfully updated.'
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
