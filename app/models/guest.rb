class Guest < ActiveRecord::Base
  belongs_to :product

  attr_accessor :total_guests

  validates :name, presence: true
end
