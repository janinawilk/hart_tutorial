class Micropost < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
end
