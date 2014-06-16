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
    
    if @reservation.save
      redirect_to(@reservation, :notice => 'Reservation was successfully created.') 
    else
      render :action => "new" 
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
    @reservation.destroy
    redirect_to(reservations_url)
  end

end
