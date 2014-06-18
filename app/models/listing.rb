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

  private
  def validate_availability
  	errors.add("Availability ") if self.availability_from >= self.availability_to
  end
end
 	