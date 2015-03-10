module Enumerable
  def sorted?
    self.each_cons(2).all? {|a,b| (a <=> b) <= 0 }
  end

  def sorted_by? &block
    self.map(&block).sorted?
  end
end