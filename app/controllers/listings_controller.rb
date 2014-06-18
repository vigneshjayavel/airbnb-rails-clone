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
    result = Listing.validate_and_create params, current_user
    process_result_from_model result
  end

  def update
    listing_from_id
    result = Listing.validate_and_update params, @listing, current_user
    process_result_from_model result
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

  private
  def listing_from_id
    @listing = Listing.find(params[:id])
  end

  def process_result_from_model result
    if !result[:error]
      flash_and_redirect result
    else
      flash_and_render_action result
    end
  end
end
