class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    
    has_secure_password
    
    has_many :foods
    
    has_many :favorites
    has_many :favorite_foods, through: :favorites, source: :food
    
    
    def favorite(food)
        self.favorites.find_or_create_by(food_id: food.id)
    end
    
    def unfavorite(food)
        favorite = self.favorites.find_by(food_id: food.id)
        favorite.destroy if favorite
    end
        
    def favorite?(food)
        self.favorite_foods.include?(food)
    end
end
