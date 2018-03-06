class Food < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :calorie, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 1000 }
  #validates :image_url, presence: true, length: { maximum: 255 }
  validates :comment, presence: true, length: { maximum: 255 }

end
