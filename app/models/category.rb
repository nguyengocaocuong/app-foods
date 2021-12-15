class Category < ApplicationRecord
    validates :image, presence: true
    validates :description , presence: true

    has_one_attached :image
    has_many :foods
end
