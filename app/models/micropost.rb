class Micropost < ApplicationRecord
  belongs_to :user
  #Userを繋げる
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favos, dependent: :destroy
end
