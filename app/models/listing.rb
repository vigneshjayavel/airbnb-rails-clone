class Listing < ActiveRecord::Base

	# Associations
  belongs_to :user

  named_scope :not_belonging_to_current_user, lambda { |current_user_id| 
    { :conditions => ["user_id != ?", current_user_id] }
  }

  named_scope :apply_full_search_criteria, lambda { |place, guests_count, check_in, check_out| 
    {
      :conditions => ["place = ? and maximum_guests >= ? and availability_from <= ? and availability_to >= ? ", place, guests_count, check_in, check_out]
    }
  }

  named_scope :apply_place_search_criteria, lambda { |place| 
    {
      :conditions => ["place = ?", place] 
    }
  }

  has_many :reservations,:dependent => :destroy

  #paperclip gem configs
  has_attached_file :snap, 
  :styles => { 
    :medium => "300x300>", 
    :thumb => "100x100>"
  }, 
  :default_url => "/images/default_:style.png"

  # Validations
  validates_presence_of :name, :address, :price
  validate :validate_availability

  #paperclip validation
  # validates_attachment_presence :snap

  def self.get_listings_for_search_attr(search_attr, current_user)
    if search_attr[:guests_count]!=nil && search_attr[:place]!=nil
      check_in = "#{search_attr["check_in(1i)"]}-#{search_attr["check_in(2i)"]}-#{search_attr["check_in(3i)"]}"
      check_out = "#{search_attr["check_out(1i)"]}-#{search_attr["check_out(2i)"]}-#{search_attr["check_out(3i)"]}"
      Listing.not_belonging_to_current_user(current_user).apply_full_search_criteria(search_attr[:place], search_attr[:guests_count], check_in, check_out)
    elsif search_attr[:place] != nil
      Listing.not_belonging_to_current_user(current_user.id).apply_place_search_criteria(search_attr[:place])
    else
      Listing.not_belonging_to_current_user(current_user.id)
    end
  end

  def self.validate_and_create(params, current_user)
    listing = current_user.listings.new(params[:listing])
    result = {}
    if listing.save
      result[:message] = "Listing was successfully created."
      result[:path] = listing
    else
      result[:message] = listing.errors.full_messages.to_sentence
      result[:path] = {:action => "new"}
      result[:error] = true
    end
    return result
  end

  def self.validate_and_update(params, listing, current_user)
    result = {}
    if listing.update_attributes(params[:listing])
      result[:message] = 'Listing was successfully updated.'
      result[:path] = listing
    else
      result[:message] = listing.errors.full_messages.to_sentence
      result[:path] = {:action => "edit"}
      result[:error] = true
    end
    return result
  end

  private
  def validate_availability
  	errors.add("Availability ") if self.availability_from >= self.availability_to
  end
end
 	