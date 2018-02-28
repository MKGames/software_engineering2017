class Order < ApplicationRecord
  belongs_to :product

  validates :ordered_at, presence: true

  default_scope { order(:ordered_at) }

  def to_s
    "Order ##{id} for #{product} (#{ordered_at})"
  end
end
