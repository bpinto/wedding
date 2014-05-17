class Guest < ActiveRecord::Base
  attr_accessor :total_guests

  validates :name, presence: true
end
