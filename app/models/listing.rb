class Listing < ActiveRecord::Base

	# Associations
  belongs_to :user

  named_scope :not_belonging_to_current_user, lambda { |current_user_id| 
    { :conditions => ["user_id != ?", current_user_id] }
  }

  has_many :reservations

  # Validations
  validates_presence_of :name, :address
  validate :validate_availability

  private
  def validate_availability
  	errors.add("Availability ") if self.availability_from >= self.availability_to
  end
end
 	