class User < ApplicationRecord
  has_one_attached :image, dependent: false
  has_many :created_rooms, class_name: "Room", foreign_key: "owner_id"
  has_many :reservations
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  validates :image,
    content_type: [:png, :jpg, :jpeg],
    size: { less_than_or_equal_to: 10.megabytes },
    dimension: {width: {max: 2000 }, height: { max: 2000 } }
  
  attr_accessor :remove_image
  
  before_save :remove_image_if_user_accept
  
  private
  
  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end  
  
  
end
