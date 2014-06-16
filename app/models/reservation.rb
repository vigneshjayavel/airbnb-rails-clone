class Reservation < ActiveRecord::Base

	#Associations
	belongs_to :user
	belongs_to :listing

	#Validations
	validates_presence_of :guests_count

	def reservation_period_validation
		errors.add("Reservation period ") if self.check_in >= self.check_out
	end

end
