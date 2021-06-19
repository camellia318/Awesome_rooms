class Room < ApplicationRecord
  has_one_attached :image, dependent: false
  has_many :reservations, dependent: :destroy
  belongs_to :owner, class_name: "User"
  
  validates :name, length: { maximum: 15 }, presence: true
  validates :adress, length: { maximum: 15 }, presence: true
  validates :price, presence: true
  validates :description, length: { maximum: 2000 }, presence: true
  validates :image,
    content_type: [:png, :jpg, :jpeg],
    size: { less_than_or_equal_to: 10.megabytes },
    dimension: {width: {max: 2000 }, height: { max: 2000 } }

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end
  
  attr_accessor :remove_image
  
  before_save :remove_image_if_user_accept
  
  private
  
  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end  
  
end  