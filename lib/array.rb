class Array
  def lfill(pad_length, pad_value)
    self.reverse!
    self.fill(pad_value, (self.length..(pad_length-1)))
    self.reverse!
  end
end
