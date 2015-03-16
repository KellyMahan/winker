
class Float
  def to_time
    Time.at(self)
  end
  def to_date
    self.to_time.to_date
  end
end