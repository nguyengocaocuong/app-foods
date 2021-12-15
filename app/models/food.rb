class Food < ApplicationRecord
    validates :image, presence: true
    belongs_to :category
    has_one_attached :image

end
