class ListingsController < ApplicationController

  def index
    @listings = Listing.not_belonging_to_current_user(current_user.id)
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def create
    @listing = current_user.listings.new(params[:listing])

    if @listing.save
      redirect_to(@listing, :notice => 'Listing was successfully created.') 
    else
      render :action => "new"
    end
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update_attributes(params[:listing])
      redirect_to(@listing, :notice => 'Listing was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    redirect_to(listings_url)
  end

  def reserve
    @listing = Listing.find(params[:id])
    @reservation = @listing.reservations.new
  end

end
