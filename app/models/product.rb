class Product < ActiveRecord::Base
  has_many :guests

  def price_value
    price.scan(/\d+|,/).join.gsub(',', '.').to_f
  end

  def <=>(other)
    price_value <=> other.price_value
  end
end
