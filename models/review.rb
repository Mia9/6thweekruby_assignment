class Review < ActiveRecord::Base
	belongs_to :user, required: true
	belongs_to :movie, required: true
	validates :score, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 1,
		less_than_or_equal_to: 10
	}
end