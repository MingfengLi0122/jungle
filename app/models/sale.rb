class Sale < ActiveRecord::Base
  # socpe :active, -> {  where("sales.starts_on < ? AND sales.ends_on >= ?", Date.current, Date.current) }
  # self.active class method AR scope
  def self.active
    where("sales.starts_on < ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    # equals to self.ends_on
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end
end
