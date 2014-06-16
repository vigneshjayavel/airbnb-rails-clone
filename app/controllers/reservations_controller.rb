class ReservationsController < ApplicationController
	def index
		@title = "My reservations"
		@reservations = current_user.reservations
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = current_user.reservations.new(params[:reservation])
    listing = Listing.find(params[:reservation][:listing_id])
    if Date.today > listing.availability_from && Date.today > listing.availability_to
      flash[:notice] = "The listing's availability has expired"
      redirect_to(reserve_listing_url params[:reservation][:listing_id])
    else
      if @reservation.save
        redirect_to(@reservation, :notice => 'Reservation was successfully created.') 
      else
        flash[:notice] = @reservation.errors.full_messages.to_sentence
        redirect_to(reserve_listing_url params[:reservation][:listing_id])
      end
    end

  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update_attributes(params[:reservation])
      redirect_to(@reservation, :notice => 'Reservation was successfully updated.')
    else
      render :action => "edit"
    end
    
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    listing = Listing.find(@reservation.listing_id)
    if Date.today < @reservation.check_in + listing.notice_period 
      @reservation.destroy
      redirect_to(reservations_url)
    else 
      redirect_to(@reservation, :notice => "You cannot cancel the reservation. Minimum notice period is #{listing.notice_period} days")
    end
  end

end
