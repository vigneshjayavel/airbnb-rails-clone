class User < ActiveRecord::Base
	acts_as_authentic do |c|

	end

	has_many :listings, :dependent => :destroy
end
