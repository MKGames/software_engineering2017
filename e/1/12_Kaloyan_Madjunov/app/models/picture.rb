class Picture < ApplicationRecord
	validates :url,  :format => URI::regexp(%w(http https))

	belongs_to :article
end

