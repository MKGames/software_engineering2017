class Article < ApplicationRecord
	validates_presence_of :title
	validates :description, length: {minimum: 5}

	has_many :pictures
end
