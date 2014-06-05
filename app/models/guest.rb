class Guest < ActiveRecord::Base
  attr_accessor :total_guests

  validates :name, presence: true

  scope :confirmed,   -> { where(confirmed: true) }
  scope :unconfirmed, -> { where(confirmed: false) }

  def self.total_confirmed
    total = 0
    Guest.confirmed.each do |guest|
      total += 1
      total += guest.companions.count unless guest.companions.blank?
    end

    total
  end

  def self.total_unconfirmed
    total = 0
    Guest.unconfirmed.each do |guest|
      total += 1
      total += guest.companions.size unless guest.companions.blank?
    end

    total
  end

  def total_guests
    total = 1
    total += self.companions.size unless companions.blank?
    total
  end
end
