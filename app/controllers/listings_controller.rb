class ListingsController < ApplicationController
  before_filter :require_user, :only => [:index, :new]
  def index
    if current_user
      @listings = Listing.not_belonging_to_current_user(current_user.id)
    else
      @listings = Listing.all
    end
  end

  def show
    listing_from_id
  end

  def new
    @listing = Listing.new
  end

  def edit
    listing_from_id
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
    listing_from_id
    if @listing.update_attributes(params[:listing])
      redirect_to(@listing, :notice => 'Listing was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    listing_from_id
    @listing.destroy

    redirect_to(listings_user_path(current_user.id))
  end

  def reserve
    listing_from_id
    @reservation = @listing.reservations.new
  end

  def listing_from_id
    @listing = Listing.find(params[:id])
  end

end
