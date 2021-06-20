class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room, class_name: "Room"
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_should_be_before_end_date
  
  require "date"
  
  def first_day
   start_date.to_date
  end 
    
  def last_day
    end_date.to_date
  end  
  
  #何日間かを計算
  def number_of_nights
    (last_day - first_day).to_i
  end
 
  
  def total_price
    person * room.price * number_of_nights
  end
  
  private
  
  def start_date_should_be_before_end_date
      return unless start_date && end_date
      
      if start_date >= end_date
        errors.add(:start_date, "は終了日よりも前に設定して下さい")
      end
  end
  
end
