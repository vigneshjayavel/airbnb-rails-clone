class User < ActiveRecord::Base
	acts_as_authentic do |c|

	end
end
