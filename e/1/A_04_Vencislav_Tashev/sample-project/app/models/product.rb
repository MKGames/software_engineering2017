class Product < ApplicationRecord
  validates :name,        presence: true
  validates :description, presence: true, length: { minimum: 5 }

  has_many :orders

  def to_s
    name
  end
end
