class Listing < ActiveRecord::Base

	# Associations
  belongs_to :user

  named_scope :not_belonging_to_current_user, lambda { |current_user_id| 
    { :conditions => ["user_id != ?", current_user_id] }
  }

  has_many :reservations

  #paperclip gem configs
  has_attached_file :snap, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  # Validations
  validates_presence_of :name, :address
  validate :validate_availability

  #paperclip validation
  # validates_attachment_presence

  private
  def validate_availability
  	errors.add("Availability ") if self.availability_from >= self.availability_to
  end
end
 	