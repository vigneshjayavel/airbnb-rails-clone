class Reservation < ActiveRecord::Base

	#Associations
	belongs_to :user
	belongs_to :listing

	#Validations
	validates_presence_of :guests_count
	validate :reservation_period_validation

	def self.validate_and_create(params, current_user)
    reservation = current_user.reservations.new(params[:reservation])
    listing = Listing.find(params[:reservation][:listing_id])
    if Date.today > listing.availability_from && Date.today > listing.availability_to
      message = "The listing's availability has expired"
      path = reserve_listing_path params[:reservation][:listing_id]
    elsif listing.availability_from > reservation.check_in || listing.availability_to < reservation.check_out
      message = "You can reserve this listing only for the period #{listing.availability_from} - #{listing.availability_to}"
      path = reserve_listing_path params[:reservation][:listing_id]
    else
      if reservation.save
        message = "Reservation was successfully created."
        path = reservation  
      else
        message = reservation.errors.full_messages.to_sentence
        path = reserve_listing_path params[:reservation][:listing_id]
      end
    end
    result = {
    	:message => message,
    	:path => path
    }
    return result
  end

  def self.validate_and_destroy(reservation)
    listing = Listing.find(reservation.listing_id)
    if Date.today < reservation.check_in + listing.notice_period 
      reservation.destroy
      message = "successfully cancelled the reservation!"
      path = reservations_path
    else 
      message = "You cannot cancel the reservation. Minimum notice period is #{listing.notice_period} days"
      path = (reservation)
    end
    result = {
    	:message => message,
    	:path => path
    }
    return result
  end

  def self.validate_and_update(params, reservation)
    if reservation.update_attributes(params[:reservation])
       message = "Reservation was successfully updated."
       path = reservation
    else
      message = reservation.errors.full_messages.to_sentence
      path = {:action => "edit"}
    end
    result = {
      :message => message,
      :path => path
    }
  end

	private
	def reservation_period_validation
		errors.add("Reservation period ") if self.check_in >= self.check_out
	end

end
