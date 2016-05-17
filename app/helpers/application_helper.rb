module ApplicationHelper
  def to_gold(amount)
    amount = amount.to_i
    gold = amount / 10000
    remainder = amount % 10000
    silver = remainder / 100
    copper = remainder % 100

    "#{gold}g #{silver}s #{copper}c"
  end
end
